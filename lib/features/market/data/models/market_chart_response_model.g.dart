// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_chart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketChartResponseModel _$MarketChartResponseModelFromJson(
  Map<String, dynamic> json,
) => MarketChartResponseModel(
  prices: (json['prices'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
);

Map<String, dynamic> _$MarketChartResponseModelToJson(
  MarketChartResponseModel instance,
) => <String, dynamic>{'prices': instance.prices};
