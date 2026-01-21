import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/usecases/get_market_coins.dart';
import 'package:quant_ai/features/market/domain/usecases/get_trending_coins.dart';
import 'dart:async';

part 'market_event.dart';
part 'market_state.dart';

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final GetMarketCoins _getMarketCoins;
  final GetTrendingCoins _getTrendingCoins;
  Timer? _timer;

  MarketBloc(this._getMarketCoins, this._getTrendingCoins)
    : super(MarketInitial()) {
    on<MarketDataRequested>(_onMarketDataRequested);
    on<MarketTrendingRequested>(_onTrendingRequested);

    // Start polling every 45 seconds to stay within free API limits (approx 1.3 calls/min/user)
    _timer = Timer.periodic(const Duration(seconds: 45), (_) {
      add(MarketDataRequested());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> _onMarketDataRequested(
    MarketDataRequested event,
    Emitter<MarketState> emit,
  ) async {
    // Only show loading if we don't have data yet
    if (state is! MarketLoaded) {
      emit(MarketLoading());
    }

    final result = await _getMarketCoins(NoParams());
    // Also fetch trending when market data is requested
    final trendingResult = await _getTrendingCoins(NoParams());

    result.fold(
      (failure) {
        if (state is! MarketLoaded) {
          emit(MarketError(failure.message));
        }
        // If loaded, just ignore error to keep showing old data
      },
      (coins) {
        final trending = trendingResult.getOrElse(() => []);
        emit(MarketLoaded(coins, trendingCoins: trending));
      },
    );
  }

  Future<void> _onTrendingRequested(
    MarketTrendingRequested event,
    Emitter<MarketState> emit,
  ) async {
    final result = await _getTrendingCoins(NoParams());
    result.fold(
      (failure) {
        // Don't emit error if we already have data
      },
      (trending) {
        if (state is MarketLoaded) {
          emit((state as MarketLoaded).copyWith(trendingCoins: trending));
        }
      },
    );
  }
}
