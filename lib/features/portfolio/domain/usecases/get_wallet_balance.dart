import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/portfolio/domain/repositories/portfolio_repository.dart';

@injectable
class GetWalletBalance implements UseCase<double, NoParams> {
  final PortfolioRepository _repository;

  GetWalletBalance(this._repository);

  @override
  Future<Either<Failure, double>> call(NoParams params) async {
    return await _repository.getWalletBalance();
  }
}
