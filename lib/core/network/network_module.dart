import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/config/env.dart';
import 'package:quant_ai/features/market/data/datasources/coin_gecko_service.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @lazySingleton
  CoinGeckoService getCoinGeckoService(Dio dio) => CoinGeckoService(dio);

  @lazySingleton
  GenerativeModel get generativeModel =>
      GenerativeModel(model: 'gemini-pro', apiKey: Env.geminiApiKey);
}
