import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/repositories/market_repository.dart';

@lazySingleton
class GetCoinChart implements UseCase<List<double>, String> {
  final MarketRepository repository;

  GetCoinChart(this.repository);

  @override
  Future<Either<Failure, List<double>>> call(String id) async {
    return await repository.getCoinChart(id);
  }
}
