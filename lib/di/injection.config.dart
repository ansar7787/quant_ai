// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i719;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/usecases/login_usecase.dart' as _i406;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i719.AuthRemoteDataSource>(
      () => _i719.SupabaseAuthRemoteDataSource(),
    );
    gh.lazySingleton<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(gh<_i719.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i406.LoginUseCase>(
      () => _i406.LoginUseCase(gh<_i869.AuthRepository>()),
    );
    gh.factory<_i59.AuthBloc>(() => _i59.AuthBloc(gh<_i406.LoginUseCase>()));
    return this;
  }
}
