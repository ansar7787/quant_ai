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
  Future<Either<Failure, List<Coin>>> getMarketCoins({int page = 1}) async {
    try {
      final coins = await _service.getCoins(page: page);
      return Right(coins);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coin>>> getTrendingCoins() async {
    try {
      final response = await _service.getTrending();
      final coins = response.coins.map((e) => e.item.toDomain()).toList();
      return Right(coins);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coin>>> getCoinsByIds(List<String> ids) async {
    if (ids.isEmpty) return const Right([]);
    try {
      final coins = await _service.getCoins(ids: ids.join(','));
      return Right(coins);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<double>>> getCoinChart(String id) async {
    try {
      final response = await _service.getCoinMarketChart(id);
      return Right(response.pricePoints);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
