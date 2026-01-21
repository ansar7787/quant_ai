import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/usecase/usecase.dart';
import 'package:quant_ai/features/market/domain/entities/coin.dart';
import 'package:quant_ai/features/market/domain/usecases/get_coins_by_ids.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/add_transaction.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/get_portfolio.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/get_wallet_balance.dart';
import 'package:quant_ai/features/portfolio/domain/usecases/update_wallet_balance.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio _getPortfolio;
  final AddTransaction _addTransaction;
  final GetCoinsByIds _getCoinsByIds;
  final GetWalletBalance _getWalletBalance;
  final UpdateWalletBalance _updateWalletBalance;

  PortfolioBloc(
    this._getPortfolio,
    this._addTransaction,
    this._getCoinsByIds,
    this._getWalletBalance,
    this._updateWalletBalance,
  ) : super(PortfolioInitial()) {
    on<PortfolioRequested>(_onPortfolioRequested);
    on<PortfolioTransactionAdded>(_onTransactionAdded);
    on<PortfolioBalanceUpdated>(_onBalanceUpdated);
  }

  Future<void> _onPortfolioRequested(
    PortfolioRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());
    final result = await _getPortfolio(NoParams());
    final walletResult = await _getWalletBalance(NoParams());

    final balance = walletResult.getOrElse(() => 0.0);

    await result.fold(
      (failure) async => emit(PortfolioError(failure.message)),
      (assets) async {
        if (assets.isEmpty) {
          emit(PortfolioLoaded(assets, walletBalance: balance));
          return;
        }

        final ids = assets.map((e) => e.symbol.toLowerCase()).toList();
        final pricesResult = await _getCoinsByIds(ids);

        pricesResult.fold(
          (failure) {
            emit(PortfolioLoaded(assets, walletBalance: balance));
          },
          (coins) {
            final updatedAssets = assets.map((asset) {
              final coin = coins.firstWhere(
                (c) =>
                    c.id == asset.symbol.toLowerCase() ||
                    c.symbol == asset.symbol.toLowerCase(),
                orElse: () => Coin(
                  id: asset.symbol,
                  symbol: asset.symbol,
                  name: asset.name,
                  currentPrice: asset.averagePrice,
                  priceChange24h: 0,
                  marketCap: 0,
                  marketCapRank: 0,
                  image: asset.image,
                ),
              );

              return asset.copyWith(currentPrice: coin.currentPrice);
            }).toList();

            emit(PortfolioLoaded(updatedAssets, walletBalance: balance));
          },
        );
      },
    );
  }

  Future<void> _onTransactionAdded(
    PortfolioTransactionAdded event,
    Emitter<PortfolioState> emit,
  ) async {
    await _addTransaction(
      TransactionParams(
        symbol: event.symbol,
        name: event.name,
        image: event.image,
        amount: event.amount,
        price: event.price,
      ),
    );
    add(PortfolioRequested());
  }

  Future<void> _onBalanceUpdated(
    PortfolioBalanceUpdated event,
    Emitter<PortfolioState> emit,
  ) async {
    await _updateWalletBalance(event.amount);
    add(PortfolioRequested());
  }
}
