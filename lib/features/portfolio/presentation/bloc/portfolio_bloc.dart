import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/add_transaction.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/get_portfolio.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio _getPortfolio;
  final AddTransaction _addTransaction;

  PortfolioBloc(this._getPortfolio, this._addTransaction)
    : super(PortfolioInitial()) {
    on<PortfolioRequested>(_onPortfolioRequested);
    on<PortfolioTransactionAdded>(_onTransactionAdded);
  }

  Future<void> _onPortfolioRequested(
    PortfolioRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());
    final result = await _getPortfolio(NoParams());
    result.fold(
      (failure) => emit(PortfolioError(failure.message)),
      (assets) => emit(PortfolioLoaded(assets)),
    );
  }

  Future<void> _onTransactionAdded(
    PortfolioTransactionAdded event,
    Emitter<PortfolioState> emit,
  ) async {
    // Optimistic or waiting approach? Let's just reload for now.
    await _addTransaction(
      TransactionParams(
        symbol: event.symbol,
        name: event.name,
        image: event.image,
        amount: event.amount,
        price: event.price,
      ),
    );
    // Reload portfolio
    add(PortfolioRequested());
  }
}
