import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/market/data/datasources/coin_gecko_service.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/repositories/market_repository.dart';

@LazySingleton(as: MarketRepository)
class MarketRepositoryImpl implements MarketRepository {
  final CoinGeckoService _service;

  MarketRepositoryImpl(this._service);

  @override
  Future<Either<Failure, List<Coin>>> getMarketCoins() async {
    try {
      final coins = await _service.getCoins();
      return Right(coins); // CoinModel extends Coin, so this works
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
