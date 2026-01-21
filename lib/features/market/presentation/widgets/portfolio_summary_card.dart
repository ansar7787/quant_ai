import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/core/widgets/gradient_card.dart';
import 'package:quant_ai/features/portfolio/presentation/bloc/portfolio_bloc.dart';

class PortfolioSummaryCard extends StatelessWidget {
  const PortfolioSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        double totalBalance = 0.0;
        double totalPL = 0.0;
        double plPercentage = 0.0;

        if (state is PortfolioLoaded) {
          totalBalance =
              state.assets.fold(0.0, (sum, asset) => sum + asset.totalValue) +
              state.walletBalance;

          final totalCostBasis = state.assets.fold(
            0.0,
            (sum, asset) => sum + asset.costBasis,
          );

          totalPL = totalBalance - totalCostBasis;
          if (totalCostBasis > 0) {
            plPercentage = (totalPL / totalCostBasis) * 100;
          }
        }

        final isPositive = totalPL >= 0;

        return GradientCard(
          colors: const [Color(0xFF6B4CFF), Color(0xFF9F83FF)],
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isPositive
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isPositive
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${isPositive ? '+' : ''}${plPercentage.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                '\$${totalBalance.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${isPositive ? '+' : ''}\$${totalPL.toStringAsFixed(2)} All time',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
