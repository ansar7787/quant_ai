part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final List<Coin> coins;
  final List<Coin> trendingCoins;

  const MarketLoaded(this.coins, {this.trendingCoins = const []});

  @override
  List<Object> get props => [coins, trendingCoins];

  MarketLoaded copyWith({List<Coin>? coins, List<Coin>? trendingCoins}) {
    return MarketLoaded(
      coins ?? this.coins,
      trendingCoins: trendingCoins ?? this.trendingCoins,
    );
  }
}

class MarketError extends MarketState {
  final String message;

  const MarketError(this.message);

  @override
  List<Object> get props => [message];
}
