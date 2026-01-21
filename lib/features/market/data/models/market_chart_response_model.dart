import 'package:json_annotation/json_annotation.dart';

part 'market_chart_response_model.g.dart';

@JsonSerializable()
class MarketChartResponseModel {
  // prices is a list of [timestamp, price]
  final List<List<double>> prices;

  MarketChartResponseModel({required this.prices});

  factory MarketChartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MarketChartResponseModelFromJson(json);

  List<double> get pricePoints => prices.map((e) => e[1]).toList();
}
