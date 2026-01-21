import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/portfolio/domain/repositories/portfolio_repository.dart';

@injectable
class UpdateWalletBalance implements UseCase<void, double> {
  final PortfolioRepository _repository;

  UpdateWalletBalance(this._repository);

  @override
  Future<Either<Failure, void>> call(double amount) async {
    return await _repository.updateBalance(amount);
  }
}
