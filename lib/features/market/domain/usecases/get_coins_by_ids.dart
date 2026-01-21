import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/repositories/market_repository.dart';

@lazySingleton
class GetCoinsByIds implements UseCase<List<Coin>, List<String>> {
  final MarketRepository repository;

  GetCoinsByIds(this.repository);

  @override
  Future<Either<Failure, List<Coin>>> call(List<String> ids) async {
    return await repository.getCoinsByIds(ids);
  }
}
