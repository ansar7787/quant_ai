import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/presentation/bloc/market_bloc.dart';
import 'package:quant_ai/features/market/presentation/widgets/action_buttons_row.dart';
import 'package:quant_ai/features/market/presentation/widgets/portfolio_summary_card.dart';
import 'package:quant_ai/features/market/presentation/widgets/trending_card.dart';
import 'package:quant_ai/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MarketBloc>()..add(MarketDataRequested()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<PortfolioBloc>()..add(PortfolioRequested()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MarketBloc, MarketState>(
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
                  child: CustomScrollView(
                    slivers: [
                      // 1. Header & Portfolio Summary
                      SliverPadding(
                        padding: EdgeInsets.all(16.w),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                String displayName = 'Crypto Trader';
                                String? photoUrl;
                                if (authState is AuthAuthenticated) {
                                  displayName =
                                      authState.user.displayName ??
                                      authState.user.email.split('@')[0];
                                  photoUrl = authState.user.photoUrl;
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome back,',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          displayName,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundImage: photoUrl != null
                                          ? NetworkImage(photoUrl)
                                          : const NetworkImage(
                                              'https://i.pravatar.cc/150?u=mp',
                                            ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            const PortfolioSummaryCard(),
                            SizedBox(height: 24.h),
                            const ActionButtonsRow(),
                            SizedBox(height: 32.h),
                            Text(
                              'Trending',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            const TrendingCoins(),
                            SizedBox(height: 32.h),
                            Text(
                              'Market',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ]),
                        ),
                      ),

                      // 2. All Coins List
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final coin = state.coins[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: _CoinListItem(coin: coin),
                            );
                          }, childCount: state.coins.length),
                        ),
                      ),
                      // Navigation Bar spacer
                      SliverToBoxAdapter(child: SizedBox(height: 80.h)),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
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
    return GestureDetector(
      onTap: () {
        context.push('/coin', extra: coin);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(coin.image, width: 42.w, height: 42.w),
            SizedBox(width: 16.w),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
