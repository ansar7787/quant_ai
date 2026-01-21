import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/portfolio/domain/repositories/portfolio_repository.dart';

class TransactionParams extends Equatable {
  final String symbol;
  final String name;
  final String image;
  final double amount;
  final double price;

  const TransactionParams({
    required this.symbol,
    required this.name,
    required this.image,
    required this.amount,
    required this.price,
  });

  @override
  List<Object> get props => [symbol, name, image, amount, price];
}

@lazySingleton
class AddTransaction implements UseCase<void, TransactionParams> {
  final PortfolioRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(TransactionParams params) async {
    return await repository.addTransaction(
      symbol: params.symbol,
      name: params.name,
      image: params.image,
      amount: params.amount,
      price: params.price,
    );
  }
}
