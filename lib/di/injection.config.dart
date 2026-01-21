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
import 'package:injectable/injectable.dart' as _i526;

import '../core/network/network_module.dart' as _i419;
import '../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i719;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/usecases/login_usecase.dart' as _i406;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;
import '../features/market/data/datasources/coin_gecko_service.dart' as _i840;
import '../features/market/data/repositories/market_repository_impl.dart'
    as _i27;
import '../features/market/domain/repositories/market_repository.dart' as _i852;
import '../features/market/domain/usecases/get_market_coins.dart' as _i364;
import '../features/market/presentation/bloc/market_bloc.dart' as _i955;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i840.CoinGeckoService>(
      () => networkModule.getCoinGeckoService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i719.AuthRemoteDataSource>(
      () => _i719.SupabaseAuthRemoteDataSource(),
    );
    gh.lazySingleton<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(gh<_i719.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i406.LoginUseCase>(
      () => _i406.LoginUseCase(gh<_i869.AuthRepository>()),
    );
    gh.lazySingleton<_i852.MarketRepository>(
      () => _i27.MarketRepositoryImpl(gh<_i840.CoinGeckoService>()),
    );
    gh.lazySingleton<_i364.GetMarketCoins>(
      () => _i364.GetMarketCoins(gh<_i852.MarketRepository>()),
    );
    gh.factory<_i955.MarketBloc>(
      () => _i955.MarketBloc(gh<_i364.GetMarketCoins>()),
    );
    gh.factory<_i59.AuthBloc>(() => _i59.AuthBloc(gh<_i406.LoginUseCase>()));
    return this;
  }
}

class _$NetworkModule extends _i419.NetworkModule {}
