import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';
import 'package:iddir_app/features/request/data/repositories/request_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5000/api'));
});

final requestProvider =
    StateNotifierProvider<RequestNotifier, AsyncValue<List<RequestModel>>>((ref) {
  final repo = ref.watch(requestRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return RequestNotifier(repo, prefs);
});

class RequestNotifier extends StateNotifier<AsyncValue<List<RequestModel>>> {
  final RequestRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  RequestNotifier(this.repo, this._prefs) : super(const AsyncValue.data([]));

  Future<void> getAllRequests() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final requests = await repo.getAllRequests(token);
      if (requests != null) {
        state = AsyncValue.data(requests);
      } else {
        state = AsyncValue.error('Failed to fetch requests', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> createRequest(Map<String, dynamic> data) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    final currentState = state;
    state = const AsyncValue.loading();

    try {
      final request = await repo.createRequest(token: token, data: data);
      if (request != null) {
        final currentRequests = currentState.value ?? [];
        state = AsyncValue.data([request, ...currentRequests]);
        return true;
      } else {
        state = AsyncValue.error('Failed to create request', StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateRequestStatus(String id, String status) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();

    try {
      final updatedRequest = await repo.updateRequestStatus(
        token: token,
        id: id,
        status: status,
      );

      if (updatedRequest != null) {
        await getAllRequests(); // Refresh the list
        return true;
      } else {
        state = AsyncValue.error('Failed to update request', StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}
