import 'package:dartz/dartz.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';

abstract class PortfolioRepository {
  Future<Either<Failure, List<Asset>>> getPortfolio();
  Future<Either<Failure, void>> addTransaction({
    required String symbol,
    required String name,
    required String image,
    required double amount,
    required double price,
  });
}
