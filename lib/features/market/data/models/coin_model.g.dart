// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinModel _$CoinModelFromJson(Map<String, dynamic> json) => CoinModel(
  id: json['id'] as String,
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  currentPrice: (json['current_price'] as num).toDouble(),
  priceChange24h: (json['price_change_percentage_24h'] as num).toDouble(),
  marketCap: (json['market_cap'] as num).toDouble(),
  marketCapRank: (json['market_cap_rank'] as num).toInt(),
  image: json['image'] as String,
);

Map<String, dynamic> _$CoinModelToJson(CoinModel instance) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'name': instance.name,
  'current_price': instance.currentPrice,
  'price_change_percentage_24h': instance.priceChange24h,
  'market_cap': instance.marketCap,
  'market_cap_rank': instance.marketCapRank,
  'image': instance.image,
};
