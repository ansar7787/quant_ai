import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:quant_ai/features/market/data/models/coin_model.dart';
import 'package:quant_ai/features/market/data/models/market_chart_response_model.dart';
import 'package:quant_ai/features/market/data/models/trending_response_model.dart';

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
    @Query("ids") String? ids,
    @Query("sparkline") bool sparkline = false,
  });

  @GET("/search/trending")
  Future<TrendingResponseModel> getTrending();

  @GET("/coins/{id}/market_chart")
  Future<MarketChartResponseModel> getCoinMarketChart(
    @Path("id") String id, {
    @Query("vs_currency") String vsCurrency = 'usd',
    @Query("days") String days = '1',
  });
}
