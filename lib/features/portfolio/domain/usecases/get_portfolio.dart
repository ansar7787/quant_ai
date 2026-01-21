import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';
import 'package:quant_ai/features/portfolio/domain/repositories/portfolio_repository.dart';

@lazySingleton
class GetPortfolio implements UseCase<List<Asset>, NoParams> {
  final PortfolioRepository repository;

  GetPortfolio(this.repository);

  @override
  Future<Either<Failure, List<Asset>>> call(NoParams params) async {
    return await repository.getPortfolio();
  }
}
