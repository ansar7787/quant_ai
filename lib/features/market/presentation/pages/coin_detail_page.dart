import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/presentation/bloc/coin_detail/coin_detail_bloc.dart';

class CoinDetailPage extends StatelessWidget {
  final Coin coin;

  const CoinDetailPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CoinDetailBloc>()..add(CoinDetailLoadRequested(coin.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(coin.name),
          actions: [
            IconButton(icon: const Icon(Icons.star_border), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Text(
                    '\$${coin.currentPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${coin.priceChange24h >= 0 ? '+' : ''}${coin.priceChange24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: coin.priceChange24h >= 0
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Chart
            Expanded(
              child: BlocBuilder<CoinDetailBloc, CoinDetailState>(
                builder: (context, state) {
                  if (state is CoinDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CoinDetailError) {
                    return Center(child: Text(state.message));
                  } else if (state is CoinDetailLoaded) {
                    if (state.chartData.isEmpty) {
                      return const Center(
                        child: Text("No chart data data available"),
                      );
                    }
                    return _CoinChart(
                      data: state.chartData,
                      isPositive: coin.priceChange24h >= 0,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.all(
                24.w,
              ).copyWith(bottom: 24.w + MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Sell Logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Sell',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Buy Logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Buy',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinChart extends StatelessWidget {
  final List<double> data;
  final bool isPositive;

  const _CoinChart({required this.data, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    // Normalize data for chart if needed, or just plot prices.
    // FLChart handles scaling automatically if we set minY/maxY properly.

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24.h),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: isPositive ? Colors.green : Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (isPositive ? Colors.green : Colors.red).withOpacity(
                  0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
