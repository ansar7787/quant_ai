import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/features/market/domain/usecases/get_coin_chart.dart';

part 'coin_detail_event.dart';
part 'coin_detail_state.dart';

@injectable
class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final GetCoinChart _getCoinChart;

  CoinDetailBloc(this._getCoinChart) : super(CoinDetailInitial()) {
    on<CoinDetailLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    CoinDetailLoadRequested event,
    Emitter<CoinDetailState> emit,
  ) async {
    emit(CoinDetailLoading());
    final result = await _getCoinChart(event.id);
    result.fold(
      (failure) => emit(CoinDetailError(failure.message)),
      (data) => emit(CoinDetailLoaded(data)),
    );
  }
}
