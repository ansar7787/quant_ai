import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:quant_ai/features/market/data/models/coin_model.dart';

part 'coin_gecko_service.g.dart';

@RestApi(baseUrl: "https://api.coingecko.com/api/v3")
abstract class CoinGeckoService {
  factory CoinGeckoService(Dio dio, {String baseUrl}) = _CoinGeckoService;

  @GET("/coins/markets")
  Future<List<CoinModel>> getCoins({
    @Query("vs_currency") String vsCurrency = 'usd',
    @Query("order") String order = 'market_cap_desc',
    @Query("per_page") int perPage = 50,
    @Query("page") int page = 1,
    @Query("sparkline") bool sparkline = false,
  });
}
