part of 'portfolio_bloc.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object> get props => [];
}

class PortfolioRequested extends PortfolioEvent {}

class PortfolioTransactionAdded extends PortfolioEvent {
  final String symbol;
  final String name;
  final String image;
  final double amount;
  final double price;

  const PortfolioTransactionAdded({
    required this.symbol,
    required this.name,
    required this.image,
    required this.amount,
    required this.price,
  });

  @override
  List<Object> get props => [symbol, name, image, amount, price];
}
