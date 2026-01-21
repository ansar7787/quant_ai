part of 'coin_detail_bloc.dart';

abstract class CoinDetailState extends Equatable {
  const CoinDetailState();

  @override
  List<Object> get props => [];
}

class CoinDetailInitial extends CoinDetailState {}

class CoinDetailLoading extends CoinDetailState {}

class CoinDetailLoaded extends CoinDetailState {
  final List<double> chartData;

  const CoinDetailLoaded(this.chartData);

  @override
  List<Object> get props => [chartData];
}

class CoinDetailError extends CoinDetailState {
  final String message;

  const CoinDetailError(this.message);

  @override
  List<Object> get props => [message];
}
