import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChange24h;
  final double marketCap;
  final int marketCapRank;
  final String image;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChange24h,
    required this.marketCap,
    required this.marketCapRank,
    required this.image,
  });

  @override
  List<Object> get props => [
    id,
    symbol,
    name,
    currentPrice,
    priceChange24h,
    marketCap,
    marketCapRank,
    image,
  ];
}
