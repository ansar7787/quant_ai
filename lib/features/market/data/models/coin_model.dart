import 'package:json_annotation/json_annotation.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';

part 'coin_model.g.dart';

@JsonSerializable()
class CoinModel extends Coin {
  @JsonKey(name: 'price_change_percentage_24h')
  final double priceChangePercentage24h;

  const CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    @JsonKey(name: 'current_price') required super.currentPrice,
    @JsonKey(name: 'price_change_percentage_24h')
    required this.priceChangePercentage24h,
    @JsonKey(name: 'market_cap') required super.marketCap,
    required super.image,
  }) : super(priceChange24h: priceChangePercentage24h);

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinModelToJson(this);
}
