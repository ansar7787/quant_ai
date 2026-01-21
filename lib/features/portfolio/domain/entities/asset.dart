import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id; // Use symbol as ID for simplicity
  final String symbol;
  final String name;
  final String image;
  final double amount;
  final double averagePrice;

  const Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.amount,
    required this.averagePrice,
  });

  // Helper to calculate total value given current price
  double totalValue(double currentPrice) => amount * currentPrice;

  // Helper to calculate profit/loss
  double profitLoss(double currentPrice) =>
      totalValue(currentPrice) - costBasis;

  double get costBasis => amount * averagePrice;

  @override
  List<Object> get props => [id, symbol, name, image, amount, averagePrice];
}
