import 'package:dartz/dartz.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, User>> registerWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
}
