import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/exceptions.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:quant_ai/features/auth/domain/entities/user.dart';
import 'package:quant_ai/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.loginWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.registerWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return Right(user);
      } else {
        return const Left(CacheFailure('No user logged in'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
