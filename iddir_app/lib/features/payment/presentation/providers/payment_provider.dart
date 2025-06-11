import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/payment_repository.dart';
import 'package:dio/dio.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart';
import 'package:flutter/services.dart'; // For Uint8List

// Reuse the same dio provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5000/api'));
});

// Provider for user's payment details and receipt upload
final userPaymentProvider = StateNotifierProvider<UserPaymentNotifier, AsyncValue<PaymentDetails?>>((ref) {
  final repo = ref.watch(paymentRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return UserPaymentNotifier(repo, prefs);
});

// Admin providers
final paymentDetailsProvider = StateNotifierProvider<PaymentDetailsNotifier, AsyncValue<PaymentDetails?>>((ref) {
  final repo = ref.watch(paymentRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return PaymentDetailsNotifier(repo, prefs);
});

final pendingPaymentsProvider = StateNotifierProvider<PendingPaymentsNotifier, AsyncValue<List<PaymentModel>?>>((ref) {
  final repo = ref.watch(paymentRepositoryProvider(ref.watch(dioProvider)).notifier);
  final prefs = ref.watch(sharedPreferencesProvider);
  return PendingPaymentsNotifier(repo, prefs);
});

// User payment notifier for handling receipt uploads and viewing payment status
class UserPaymentNotifier extends StateNotifier<AsyncValue<PaymentDetails?>> {
  final PaymentRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  UserPaymentNotifier(this.repo, this._prefs) : super(const AsyncValue.data(null));

  Future<void> getPaymentDetails() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final details = await repo.getPaymentDetails(token: token);
    if (details != null) {
      state = AsyncValue.data(details);
    } else {
      state = AsyncValue.error('Failed to fetch payment details', StackTrace.current);
    }
  }

  Future<bool> uploadReceipt({
    String? filePath,
    Uint8List? imageBytes,
    String? fileName,
  }) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    try {
      state = const AsyncValue.loading();
      final receiptUrl = await repo.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: imageBytes,
        fileName: fileName,
      );
      
      if (receiptUrl != null) {
        // Refresh payment details to get updated status
        await getPaymentDetails();
        return true;
      }
      return false;
    } catch (e) {
      state = AsyncValue.error('Failed to upload receipt: $e', StackTrace.current);
      return false;
    }
  }
}

class PaymentDetailsNotifier extends StateNotifier<AsyncValue<PaymentDetails?>> {
  final PaymentRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  PaymentDetailsNotifier(this.repo, this._prefs) : super(const AsyncValue.data(null));

  Future<void> getPaymentDetails() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final details = await repo.getPaymentDetails(token: token);
    if (details != null) {
      state = AsyncValue.data(details);
    } else {
      state = AsyncValue.error('Failed to fetch payment details', StackTrace.current);
    }
  }
}

class PendingPaymentsNotifier extends StateNotifier<AsyncValue<List<PaymentModel>?>> {
  final PaymentRepository repo;
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  PendingPaymentsNotifier(this.repo, this._prefs) : super(const AsyncValue.data(null));

  Future<void> getPendingPayments() async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final payments = await repo.getPendingPayments(token: token);
    if (payments != null) {
      state = AsyncValue.data(payments);
    } else {
      state = AsyncValue.error('Failed to fetch pending payments', StackTrace.current);
    }
  }

  Future<bool> updatePaymentStatus(String userId, String status) async {
    final token = _prefs.getString(_tokenKey);
    if (token == null) {
      state = AsyncValue.error('Not logged in', StackTrace.current);
      return false;
    }

    try {
      final success = await repo.updatePaymentStatus(
        token: token,
        userId: userId,
        status: status,
      );
      
      if (success) {
        // Refresh the pending payments list
        await getPendingPayments();
      }
      return success;
    } catch (e) {
      state = AsyncValue.error('Failed to update payment status: $e', StackTrace.current);
      return false;
    }
  }
}
