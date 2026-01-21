import 'package:json_annotation/json_annotation.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';

part 'coin_model.g.dart';

@JsonSerializable()
class CoinModel extends Coin {
  @override
  final String id;
  @override
  final String symbol;
  @override
  final String name;
  @override
  @JsonKey(name: 'current_price')
  final double currentPrice;
  @override
  @JsonKey(name: 'price_change_percentage_24h')
  final double priceChange24h;
  @override
  @JsonKey(name: 'market_cap')
  final double marketCap;
  @override
  @JsonKey(name: 'market_cap_rank')
  final int marketCapRank;
  @override
  final String image;

  const CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChange24h,
    required this.marketCap,
    required this.marketCapRank,
    required this.image,
  }) : super(
         id: id,
         symbol: symbol,
         name: name,
         currentPrice: currentPrice,
         marketCap: marketCap,
         marketCapRank: marketCapRank,
         image: image,
         priceChange24h: priceChange24h,
       );

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinModelToJson(this);
}
