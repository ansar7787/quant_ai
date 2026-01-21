// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingResponseModel _$TrendingResponseModelFromJson(
  Map<String, dynamic> json,
) => TrendingResponseModel(
  coins: (json['coins'] as List<dynamic>)
      .map((e) => TrendingCoinItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TrendingResponseModelToJson(
  TrendingResponseModel instance,
) => <String, dynamic>{'coins': instance.coins};

TrendingCoinItem _$TrendingCoinItemFromJson(Map<String, dynamic> json) =>
    TrendingCoinItem(
      item: TrendingCoinItemData.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendingCoinItemToJson(TrendingCoinItem instance) =>
    <String, dynamic>{'item': instance.item};

TrendingCoinItemData _$TrendingCoinItemDataFromJson(
  Map<String, dynamic> json,
) => TrendingCoinItemData(
  id: json['id'] as String,
  coinId: (json['coin_id'] as num).toInt(),
  name: json['name'] as String,
  symbol: json['symbol'] as String,
  marketCapRank: (json['market_cap_rank'] as num?)?.toInt(),
  thumb: json['thumb'] as String,
  small: json['small'] as String,
  large: json['large'] as String,
  slug: json['slug'] as String,
  priceBtc: (json['price_btc'] as num).toDouble(),
  score: (json['score'] as num).toInt(),
);

Map<String, dynamic> _$TrendingCoinItemDataToJson(
  TrendingCoinItemData instance,
) => <String, dynamic>{
  'id': instance.id,
  'coin_id': instance.coinId,
  'name': instance.name,
  'symbol': instance.symbol,
  'market_cap_rank': instance.marketCapRank,
  'thumb': instance.thumb,
  'small': instance.small,
  'large': instance.large,
  'slug': instance.slug,
  'price_btc': instance.priceBtc,
  'score': instance.score,
};
