import 'package:injectable/injectable.dart';
import 'package:quant_ai/features/auth/domain/entities/user.dart';
import 'package:quant_ai/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class GetAuthStateStreamUseCase {
  final AuthRepository _repository;

  GetAuthStateStreamUseCase(this._repository);

  Stream<User?> call() {
    return _repository.authStateChanges;
  }
}
