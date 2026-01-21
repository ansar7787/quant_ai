import 'package:dartz/dartz.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';

abstract class MarketRepository {
  Future<Either<Failure, List<Coin>>> getMarketCoins();
}
