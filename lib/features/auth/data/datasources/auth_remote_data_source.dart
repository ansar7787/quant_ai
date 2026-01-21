import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:quant_ai/core/error/exceptions.dart';
import 'package:quant_ai/features/auth/domain/entities/user.dart' as domain;

abstract class AuthRemoteDataSource {
  Future<domain.User> loginWithEmailAndPassword(String email, String password);
  Future<domain.User> registerWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> logout();
  Future<domain.User?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseAuthRemoteDataSource() : _supabaseClient = Supabase.instance.client;

  @override
  Future<domain.User> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('Login failed: User is null');
      }

      return _mapSupabaseUserToDomain(response.user!);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<domain.User> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('Registration failed: User is null');
      }

      return _mapSupabaseUserToDomain(response.user!);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<domain.User?> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user != null) {
        return _mapSupabaseUserToDomain(user);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  domain.User _mapSupabaseUserToDomain(User user) {
    return domain.User(
      id: user.id,
      email: user.email ?? '',
      // Supabase stores metadata in user_metadata
      displayName: user.userMetadata?['display_name'],
      photoUrl: user.userMetadata?['avatar_url'],
    );
  }
}
