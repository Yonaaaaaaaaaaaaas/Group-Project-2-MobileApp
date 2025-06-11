import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5000/api'));
});

// SharedPreferences provider
// final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
//   throw UnimplementedError('Initialize SharedPreferences before using');
// });

// DO NOT redefine authRepositoryProvider! Use the generated one.

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  final repo = ref.watch(authRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthNotifier(repo, prefs);
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  AuthNotifier(this.repo, this._prefs) : super(const AsyncValue.loading()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      await getMe();
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await repo.login(email: email, password: password);
    if (result != null && result['user'] != null) {
      await _prefs.setString(_tokenKey, result['token']);
      state = AsyncValue.data(UserModel.fromJson(result['user']));
    } else {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    final result = await repo.register(data: data);
    if (result != null && result['user'] != null) {
      await _prefs.setString(_tokenKey, result['token']);
      state = AsyncValue.data(UserModel.fromJson(result['user']));
    } else {
      state = AsyncValue.error('Registration failed', StackTrace.current);
    }
  }

  Future<void> getMe() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }
    state = const AsyncValue.loading();
    final user = await repo.getMe(token: token);
    if (user != null) {
      state = AsyncValue.data(user);
    } else {
      state = AsyncValue.error('Failed to fetch user', StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
    state = const AsyncValue.data(null);
  }
}