import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart';

// Dio provider (reuse from auth)
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5000/api'));
});

// SharedPreferences provider (reuse from auth)
// final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
//   throw UnimplementedError('Initialize SharedPreferences before using');
// });

// DO NOT redefine profileRepositoryProvider! Use the generated one.

final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel?>>((ref) {
  final repo = ref.watch(profileRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProfileNotifier(repo, prefs);
});

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel?>> {
  final ProfileRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token'; // Reuse from auth

  ProfileNotifier(this.repo, this._prefs) : super(const AsyncValue.data(null));

  Future<void> initializeProfile() async {
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      await getProfile();
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> getProfile() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }
    state = const AsyncValue.loading();
    final profile = await repo.getProfile(token: token);
    if (profile != null) {
      state = AsyncValue.data(profile);
    } else {
      state = AsyncValue.error('Failed to fetch profile', StackTrace.current);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    final profile = await repo.updateProfile(token: token, data: data);
    if (profile != null) {
      state = AsyncValue.data(profile);
    } else {
      state = AsyncValue.error('Failed to update profile', StackTrace.current);
    }
  }

  Future<void> updateProfilePicture(dynamic imageData) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    final picturePath = await repo.updateProfilePicture(token: token, imageData: imageData);
    if (picturePath != null) {
      // Update the current profile with new picture
      final currentProfile = state.value;
      if (currentProfile != null) {
        state = AsyncValue.data(currentProfile.copyWith(profilePicture: picturePath));
      }
    } else {
      state = AsyncValue.error('Failed to update profile picture', StackTrace.current);
    }
  }

  Future<bool> deleteAccount() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    final success = await repo.deleteAccount(token: token);
    if (success) {
      // Clear profile state
      state = const AsyncValue.data(null);
      // Optionally clear auth token
      await _prefs.remove(_tokenKey);
    } else {
      state = AsyncValue.error('Failed to delete account', StackTrace.current);
    }
    return success;
  }
}

