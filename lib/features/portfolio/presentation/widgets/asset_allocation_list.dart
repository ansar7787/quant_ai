import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';

class AssetAllocationList extends StatelessWidget {
  final List<Asset> assets;

  const AssetAllocationList({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    if (assets.isEmpty) return const SizedBox.shrink();

    return Column(
      children: assets.asMap().entries.map((entry) {
        final index = entry.key;
        final asset = entry.value;
        final color = Colors.primaries[index % Colors.primaries.length];
        final totalValue = asset.amount * asset.averagePrice;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              SizedBox(width: 12.w),
              Text(
                asset.symbol.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${totalValue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '${asset.amount.toStringAsFixed(4)} ${asset.symbol.toUpperCase()}',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
