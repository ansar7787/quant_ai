import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/usecases/get_market_coins.dart';

part 'market_event.dart';
part 'market_state.dart';

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final GetMarketCoins _getMarketCoins;

  MarketBloc(this._getMarketCoins) : super(MarketInitial()) {
    on<MarketDataRequested>(_onMarketDataRequested);
  }

  Future<void> _onMarketDataRequested(
    MarketDataRequested event,
    Emitter<MarketState> emit,
  ) async {
    emit(MarketLoading());
    final result = await _getMarketCoins(NoParams());
    result.fold(
      (failure) => emit(MarketError(failure.message)),
      (coins) => emit(MarketLoaded(coins)),
    );
  }
}
