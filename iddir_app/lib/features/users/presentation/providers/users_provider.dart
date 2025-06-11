import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/users_model.dart';
import '../../data/repositories/users_repository.dart';
import 'package:dio/dio.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart';

// Reuse the same dio provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5000/api'));
});

final usersProvider = StateNotifierProvider<UsersNotifier, AsyncValue<List<UsersModel>?>>((ref) {
  final repo = ref.watch(usersRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return UsersNotifier(repo, prefs);
});

final singleUserProvider = StateNotifierProvider.family<SingleUserNotifier, AsyncValue<UsersModel?>, String>((ref, userId) {
  final repo = ref.watch(usersRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return SingleUserNotifier(repo, prefs, userId);
});

class UsersNotifier extends StateNotifier<AsyncValue<List<UsersModel>?>> {
  final UsersRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  UsersNotifier(this.repo, this._prefs) : super(const AsyncValue.data(null));

  Future<void> initializeUsers() async {
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      await getAllUsers();
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> getAllUsers() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final users = await repo.getAllUsers(token: token);
    if (users != null) {
      state = AsyncValue.data(users);
    } else {
      state = AsyncValue.error('Failed to fetch users', StackTrace.current);
    }
  }

  Future<bool> deleteUser(String userId) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    try {
      final success = await repo.deleteUser(token: token, userId: userId);
      if (success) {
        // Remove the deleted user from the current state
        state.whenData((users) {
          if (users != null) {
            final updatedUsers = users.where((user) => user.id != userId).toList();
            state = AsyncValue.data(updatedUsers);
          }
        });
      }
      return success;
    } catch (e) {
      state = AsyncValue.error('Failed to delete user: $e', StackTrace.current);
      return false;
    }
  }
}

class SingleUserNotifier extends StateNotifier<AsyncValue<UsersModel?>> {
  final UsersRepository repo;
  final SharedPreferences _prefs;
  final String userId;
  static const String _tokenKey = 'auth_token';

  SingleUserNotifier(this.repo, this._prefs, this.userId) : super(const AsyncValue.data(null));

  Future<void> getUser() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final user = await repo.getUser(token: token, userId: userId);
    if (user != null) {
      state = AsyncValue.data(user);
    } else {
      state = AsyncValue.error('Failed to fetch user', StackTrace.current);
    }
  }
}
