import 'package:json_annotation/json_annotation.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';

part 'trending_response_model.g.dart';

@JsonSerializable()
class TrendingResponseModel {
  final List<TrendingCoinItem> coins;

  TrendingResponseModel({required this.coins});

  factory TrendingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingResponseModelFromJson(json);
}

@JsonSerializable()
class TrendingCoinItem {
  final TrendingCoinItemData item;

  TrendingCoinItem({required this.item});

  factory TrendingCoinItem.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinItemFromJson(json);
}

@JsonSerializable()
class TrendingCoinItemData {
  final String id;
  @JsonKey(name: 'coin_id')
  final int coinId;
  final String name;
  final String symbol;
  @JsonKey(name: 'market_cap_rank')
  final int? marketCapRank;
  final String thumb;
  final String small;
  final String large;
  final String slug;
  @JsonKey(name: 'price_btc')
  final double priceBtc;
  final int score;

  // Trending endpoint doesn't return USD price directly in the main object,
  // but for simplicity we will map what's available or fetch details later.
  // For now we will map this to a partial Coin entity.

  TrendingCoinItemData({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    this.marketCapRank,
    required this.thumb,
    required this.small,
    required this.large,
    required this.slug,
    required this.priceBtc,
    required this.score,
  });

  factory TrendingCoinItemData.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinItemDataFromJson(json);

  Coin toDomain() {
    return Coin(
      id: id,
      symbol: symbol,
      name: name,
      image: large,
      currentPrice: 0.0, // Unavailable in this endpoint
      marketCap: 0.0,
      marketCapRank: marketCapRank ?? 0,
      priceChange24h: 0.0, // Unavailable
    );
  }
}
