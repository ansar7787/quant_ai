import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id; // Use symbol as ID for simplicity
  final String symbol;
  final String name;
  final String image;
  final double amount;
  final double averagePrice;
  final double currentPrice;

  const Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.amount,
    required this.averagePrice,
    this.currentPrice = 0.0,
  });

  // Helper to calculate total value
  double get totalValue =>
      amount * (currentPrice > 0 ? currentPrice : averagePrice);

  // Helper to calculate profit/loss
  double get profitLoss => totalValue - costBasis;

  double get costBasis => amount * averagePrice;

  Asset copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? amount,
    double? averagePrice,
    double? currentPrice,
  }) {
    return Asset(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      currentPrice: currentPrice ?? this.currentPrice,
    );
  }

  @override
  List<Object> get props => [
    id,
    symbol,
    name,
    image,
    amount,
    averagePrice,
    currentPrice,
  ];
}
