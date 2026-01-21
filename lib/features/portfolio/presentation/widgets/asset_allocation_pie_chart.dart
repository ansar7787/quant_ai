import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';

class AssetAllocationPieChart extends StatefulWidget {
  final List<Asset> assets;

  const AssetAllocationPieChart({super.key, required this.assets});

  @override
  State<AssetAllocationPieChart> createState() =>
      _AssetAllocationPieChartState();
}

class _AssetAllocationPieChartState extends State<AssetAllocationPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.assets.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: Text('Add assets to see allocation')),
      );
    }

    return SizedBox(
      height: 250.h,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: _showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(widget.assets.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      final asset = widget.assets[i];

      // Generate a color based on index
      final color = Colors.primaries[i % Colors.primaries.length];

      return PieChartSectionData(
        color: color,
        value: asset.amount * asset.averagePrice,
        title: asset.symbol.toUpperCase(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }
}
