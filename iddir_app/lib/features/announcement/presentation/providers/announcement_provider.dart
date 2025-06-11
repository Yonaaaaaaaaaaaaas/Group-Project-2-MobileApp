import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/announcement_model.dart';
import '../../data/repositories/announcement_repository.dart';
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

final announcementProvider = StateNotifierProvider<AnnouncementNotifier, AsyncValue<List<AnnouncementModel>>>((ref) {
  final repo = ref.watch(announcementRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AnnouncementNotifier(repo, prefs);
});

class AnnouncementNotifier extends StateNotifier<AsyncValue<List<AnnouncementModel>>> {
  final AnnouncementRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token'; // Reuse from auth

  AnnouncementNotifier(this.repo, this._prefs) : super(const AsyncValue.data([]));

  Future<void> getAllAnnouncements() async {
    state = const AsyncValue.loading();
    final announcements = await repo.getAllAnnouncements();
    if (announcements != null) {
      state = AsyncValue.data(announcements);
    } else {
      state = AsyncValue.error('Failed to fetch announcements', StackTrace.current);
    }
  }

  Future<bool> createAnnouncement(Map<String, dynamic> data, dynamic imageData) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();
    final announcement = await repo.createAnnouncement(
      token: token,
      data: data,
      imageData: imageData,
    );
    if (announcement != null) {
      final currentAnnouncements = state.value ?? [];
      state = AsyncValue.data([announcement, ...currentAnnouncements]);
      return true;
    } else {
      state = AsyncValue.error('Failed to create announcement', StackTrace.current);
      return false;
    }
  }

  Future<bool> updateAnnouncement(String id, Map<String, dynamic> data, dynamic imageData) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();
    final updatedAnnouncement = await repo.updateAnnouncement(
      token: token,
      id: id,
      data: data,
      imageData: imageData,
    );
    if (updatedAnnouncement != null) {
      final currentAnnouncements = state.value ?? [];
      final index = currentAnnouncements.indexWhere((a) => a.id == id);
      if (index != -1) {
        final updatedList = List<AnnouncementModel>.from(currentAnnouncements);
        updatedList[index] = updatedAnnouncement;
        state = AsyncValue.data(updatedList);
      }
      return true;
    } else {
      state = AsyncValue.error('Failed to update announcement', StackTrace.current);
      return false;
    }
  }

  Future<bool> deleteAnnouncement(String id) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();
    final success = await repo.deleteAnnouncement(
      token: token,
      id: id,
    );
    if (success) {
      final currentAnnouncements = state.value ?? [];
      final updatedList = currentAnnouncements.where((a) => a.id != id).toList();
      state = AsyncValue.data(updatedList);
      return true;
    } else {
      state = AsyncValue.error('Failed to delete announcement', StackTrace.current);
      return false;
    }
  }
}
