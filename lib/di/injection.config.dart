// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;

import '../config/routes/app_router.dart' as _i691;
import '../core/database/app_database.dart' as _i935;
import '../core/database/database_module.dart' as _i223;
import '../core/network/network_module.dart' as _i419;
import '../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i719;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/usecases/get_auth_stream_usecase.dart' as _i163;
import '../features/auth/domain/usecases/login_usecase.dart' as _i406;
import '../features/auth/domain/usecases/register_usecase.dart' as _i819;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;
import '../features/chat/data/repositories/chat_repository_impl.dart' as _i330;
import '../features/chat/domain/repositories/chat_repository.dart' as _i394;
import '../features/chat/presentation/bloc/chat_bloc.dart' as _i717;
import '../features/market/data/datasources/coin_gecko_service.dart' as _i840;
import '../features/market/data/repositories/market_repository_impl.dart'
    as _i27;
import '../features/market/domain/repositories/market_repository.dart' as _i852;
import '../features/market/domain/usecases/get_coin_chart.dart' as _i798;
import '../features/market/domain/usecases/get_coins_by_ids.dart' as _i391;
import '../features/market/domain/usecases/get_market_coins.dart' as _i364;
import '../features/market/domain/usecases/get_trending_coins.dart' as _i642;
import '../features/market/presentation/bloc/coin_detail/coin_detail_bloc.dart'
    as _i749;
import '../features/market/presentation/bloc/market_bloc.dart' as _i955;
import '../features/portfolio/data/repositories/portfolio_repository_impl.dart'
    as _i742;
import '../features/portfolio/domain/repositories/portfolio_repository.dart'
    as _i817;
import '../features/portfolio/domain/usecases/add_transaction.dart' as _i901;
import '../features/portfolio/domain/usecases/get_portfolio.dart' as _i573;
import '../features/portfolio/domain/usecases/get_wallet_balance.dart' as _i167;
import '../features/portfolio/domain/usecases/update_wallet_balance.dart'
    as _i1063;
import '../features/portfolio/presentation/bloc/portfolio_bloc.dart' as _i7;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i935.AppDatabase>(() => databaseModule.appDatabase);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i656.GenerativeModel>(
      () => networkModule.generativeModel,
    );
    gh.lazySingleton<_i394.ChatRepository>(
      () => _i330.ChatRepositoryImpl(gh<_i656.GenerativeModel>()),
    );
    gh.lazySingleton<_i840.CoinGeckoService>(
      () => networkModule.getCoinGeckoService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i719.AuthRemoteDataSource>(
      () => _i719.SupabaseAuthRemoteDataSource(),
    );
    gh.factory<_i717.ChatBloc>(
      () => _i717.ChatBloc(gh<_i394.ChatRepository>()),
    );
    gh.lazySingleton<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(gh<_i719.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i406.LoginUseCase>(
      () => _i406.LoginUseCase(gh<_i869.AuthRepository>()),
    );
    gh.lazySingleton<_i819.RegisterUseCase>(
      () => _i819.RegisterUseCase(gh<_i869.AuthRepository>()),
    );
    gh.lazySingleton<_i817.PortfolioRepository>(
      () => _i742.PortfolioRepositoryImpl(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i901.AddTransaction>(
      () => _i901.AddTransaction(gh<_i817.PortfolioRepository>()),
    );
    gh.lazySingleton<_i573.GetPortfolio>(
      () => _i573.GetPortfolio(gh<_i817.PortfolioRepository>()),
    );
    gh.lazySingleton<_i852.MarketRepository>(
      () => _i27.MarketRepositoryImpl(gh<_i840.CoinGeckoService>()),
    );
    gh.lazySingleton<_i163.GetAuthStateStreamUseCase>(
      () => _i163.GetAuthStateStreamUseCase(gh<_i869.AuthRepository>()),
    );
    gh.factory<_i167.GetWalletBalance>(
      () => _i167.GetWalletBalance(gh<_i817.PortfolioRepository>()),
    );
    gh.factory<_i1063.UpdateWalletBalance>(
      () => _i1063.UpdateWalletBalance(gh<_i817.PortfolioRepository>()),
    );
    gh.lazySingleton<_i798.GetCoinChart>(
      () => _i798.GetCoinChart(gh<_i852.MarketRepository>()),
    );
    gh.lazySingleton<_i391.GetCoinsByIds>(
      () => _i391.GetCoinsByIds(gh<_i852.MarketRepository>()),
    );
    gh.lazySingleton<_i364.GetMarketCoins>(
      () => _i364.GetMarketCoins(gh<_i852.MarketRepository>()),
    );
    gh.lazySingleton<_i642.GetTrendingCoins>(
      () => _i642.GetTrendingCoins(gh<_i852.MarketRepository>()),
    );
    gh.factory<_i955.MarketBloc>(
      () => _i955.MarketBloc(
        gh<_i364.GetMarketCoins>(),
        gh<_i642.GetTrendingCoins>(),
      ),
    );
    gh.factory<_i7.PortfolioBloc>(
      () => _i7.PortfolioBloc(
        gh<_i573.GetPortfolio>(),
        gh<_i901.AddTransaction>(),
        gh<_i391.GetCoinsByIds>(),
        gh<_i167.GetWalletBalance>(),
        gh<_i1063.UpdateWalletBalance>(),
      ),
    );
    gh.factory<_i59.AuthBloc>(
      () => _i59.AuthBloc(
        gh<_i406.LoginUseCase>(),
        gh<_i819.RegisterUseCase>(),
        gh<_i163.GetAuthStateStreamUseCase>(),
      ),
    );
    gh.factory<_i749.CoinDetailBloc>(
      () => _i749.CoinDetailBloc(gh<_i798.GetCoinChart>()),
    );
    gh.lazySingleton<_i691.AppRouter>(
      () => _i691.AppRouter(gh<_i59.AuthBloc>()),
    );
    return this;
  }
}

class _$DatabaseModule extends _i223.DatabaseModule {}

class _$NetworkModule extends _i419.NetworkModule {}
