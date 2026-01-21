import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/database/app_database.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';
import 'package:quant_ai/features/portfolio/domain/repositories/portfolio_repository.dart';

@LazySingleton(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final AppDatabase _db;

  PortfolioRepositoryImpl(this._db);

  @override
  Future<Either<Failure, List<Asset>>> getPortfolio() async {
    try {
      final rows = await _db.getAllAssets();
      final assets = rows.map((row) {
        return Asset(
          id: row.symbol,
          symbol: row.symbol,
          name: row.name,
          image: row.image,
          amount: row.amount,
          averagePrice: row.totalCost / row.amount,
        );
      }).toList();
      return Right(assets);
    } catch (e) {
      return Left(CacheFailure('Failed to load portfolio'));
    }
  }

  @override
  Future<Either<Failure, void>> addTransaction({
    required String symbol,
    required String name,
    required String image,
    required double amount,
    required double price,
  }) async {
    try {
      await _db.addTransaction(symbol, name, image, amount, price);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to add transaction'));
    }
  }

  @override
  Future<Either<Failure, double>> getWalletBalance() async {
    try {
      final balance = await _db.getWalletBalance();
      return Right(balance);
    } catch (e) {
      return Left(CacheFailure('Failed to load wallet balance'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBalance(double amount) async {
    try {
      await _db.updateBalance(amount);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update balance'));
    }
  }
}
