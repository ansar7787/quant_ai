import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/repositories/market_repository.dart';

@lazySingleton
class GetMarketCoins implements UseCase<List<Coin>, NoParams> {
  final MarketRepository repository;

  GetMarketCoins(this.repository);

  @override
  Future<Either<Failure, List<Coin>>> call(NoParams params) async {
    return await repository.getMarketCoins();
  }
}
