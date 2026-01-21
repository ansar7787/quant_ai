import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/presentation/bloc/market_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MarketBloc>()..add(MarketDataRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Live Market')),
        body: BlocBuilder<MarketBloc, MarketState>(
          builder: (context, state) {
            if (state is MarketLoading) {
              return const _MarketLoadingShimemr();
            } else if (state is MarketError) {
              return Center(child: Text(state.message));
            } else if (state is MarketLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MarketBloc>().add(MarketDataRequested());
                },
                child: ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.coins.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final coin = state.coins[index];
                    return _CoinListItem(coin: coin);
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CoinListItem extends StatelessWidget {
  final Coin coin;

  const _CoinListItem({required this.coin});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChange24h >= 0;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(coin.image, width: 32.w, height: 32.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  coin.symbol.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${coin.currentPrice.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${isPositive ? '+' : ''}${coin.priceChange24h.toStringAsFixed(2)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MarketLoadingShimemr extends StatelessWidget {
  const _MarketLoadingShimemr();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 72.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
