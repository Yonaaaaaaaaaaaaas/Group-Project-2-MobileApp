import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iddir_app/features/payment/data/models/payment_model.dart';
import 'package:iddir_app/features/payment/data/repositories/payment_repository.dart';
import 'package:iddir_app/features/payment/presentation/providers/payment_provider.dart';
import 'package:iddir_app/core/providers/shared_preferences_provider.dart'; // For sharedPreferencesProvider
import 'package:flutter/services.dart'; // For Uint8List

@GenerateMocks([PaymentRepository, SharedPreferences])
import '../../../../../../test/features/payment/presentation/providers/payment_provider_test.mocks.dart';

void main() {
  late MockPaymentRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late UserPaymentNotifier userPaymentNotifier;
  late PaymentDetailsNotifier paymentDetailsNotifier;
  late PendingPaymentsNotifier pendingPaymentsNotifier;

  final testPaymentDetails = PaymentDetails(
    paymentStatus: 'pending',
    receiptUrl: '/uploads/receipts/test.jpeg',
    paymentApprovedAt: DateTime.parse('2024-06-10T10:00:00.000Z'),
  );

  final testPendingPayments = [
    PaymentModel(
      id: '1',
      name: 'User 1',
      email: 'user1@test.com',
      paymentStatus: 'pending',
      createdAt: DateTime.parse('2024-06-10T10:00:00.000Z'),
    ),
    PaymentModel(
      id: '2',
      name: 'User 2',
      email: 'user2@test.com',
      paymentStatus: 'pending',
      createdAt: DateTime.parse('2024-06-11T10:00:00.000Z'),
    ),
  ];

  setUp(() {
    mockRepo = MockPaymentRepository();
    mockPrefs = MockSharedPreferences();
    userPaymentNotifier = UserPaymentNotifier(mockRepo, mockPrefs);
    paymentDetailsNotifier = PaymentDetailsNotifier(mockRepo, mockPrefs);
    pendingPaymentsNotifier = PendingPaymentsNotifier(mockRepo, mockPrefs);

    // Default mock behaviors
    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('UserPaymentNotifier', () {
    const testToken = 'test_token';

    test('should initialize with null payment details', () {
      expect(userPaymentNotifier.state.value, isNull);
    });

    group('getPaymentDetails', () {
      test('should update state with payment details on successful fetch', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.getPaymentDetails(token: testToken))
            .thenAnswer((_) async => testPaymentDetails);

        await userPaymentNotifier.getPaymentDetails();

        expect(userPaymentNotifier.state.value, equals(testPaymentDetails));
        verify(mockRepo.getPaymentDetails(token: testToken)).called(1);
      });

      test('should set state to null when token does not exist', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(null);

        await userPaymentNotifier.getPaymentDetails();

        expect(userPaymentNotifier.state.value, isNull);
        verifyNever(mockRepo.getPaymentDetails(token: anyNamed('token')));
      });

      test('should set state to error on fetch failure', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.getPaymentDetails(token: testToken))
            .thenAnswer((_) async => null);

        await userPaymentNotifier.getPaymentDetails();

        expect(userPaymentNotifier.state.hasError, isTrue);
        verify(mockRepo.getPaymentDetails(token: testToken)).called(1);
      });
    });

    group('uploadReceipt', () {
      const filePath = 'path/to/receipt.jpg';
      final imageBytes = Uint8List.fromList([1, 2, 3]);
      const fileName = 'receipt.jpg';
      const receiptUrl = 'http://localhost:5000/public/uploads/receipt.jpg';

      test('should upload receipt and refresh payment details on success', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.uploadReceipt(
          token: testToken,
          filePath: filePath,
          imageBytes: null,
          fileName: null,
        )).thenAnswer((_) async => receiptUrl);
        when(mockRepo.getPaymentDetails(token: testToken))
            .thenAnswer((_) async => testPaymentDetails); // For refreshing

        final result = await userPaymentNotifier.uploadReceipt(
          filePath: filePath,
          imageBytes: null,
          fileName: null,
        );

        expect(result, isTrue);
        expect(userPaymentNotifier.state.value, equals(testPaymentDetails));
        verify(mockRepo.uploadReceipt(
          token: testToken,
          filePath: filePath,
          imageBytes: null,
          fileName: null,
        )).called(1);
        verify(mockRepo.getPaymentDetails(token: testToken)).called(1);
      });

      test('should return false and set error state if no token', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(null);

        final result = await userPaymentNotifier.uploadReceipt(
          filePath: filePath,
          imageBytes: imageBytes,
          fileName: fileName,
        );

        expect(result, isFalse);
        expect(userPaymentNotifier.state.hasError, isTrue);
        expect(userPaymentNotifier.state.error.toString(), contains('Not logged in'));
        verifyNever(mockRepo.uploadReceipt(token: anyNamed('token')));
      });

      test('should return false and set error state on upload failure', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.uploadReceipt(
          token: testToken,
          filePath: null,
          imageBytes: imageBytes,
          fileName: fileName,
        )).thenThrow(Exception('Upload failed'));

        final result = await userPaymentNotifier.uploadReceipt(
          filePath: null,
          imageBytes: imageBytes,
          fileName: fileName,
        );

        expect(result, isFalse);
        expect(userPaymentNotifier.state.hasError, isTrue);
        expect(userPaymentNotifier.state.error.toString(), contains('Failed to upload receipt'));
        verify(mockRepo.uploadReceipt(
          token: testToken,
          filePath: null,
          imageBytes: imageBytes,
          fileName: fileName,
        )).called(1);
        verifyNever(mockRepo.getPaymentDetails(token: anyNamed('token')));
      });
    });
  });

  group('PaymentDetailsNotifier', () {
    const testToken = 'test_token';

    test('should initialize with null payment details', () {
      expect(paymentDetailsNotifier.state.value, isNull);
    });

    test('should update state with payment details on successful fetch', () async {
      when(mockPrefs.getString('auth_token')).thenReturn(testToken);
      when(mockRepo.getPaymentDetails(token: testToken))
          .thenAnswer((_) async => testPaymentDetails);

      await paymentDetailsNotifier.getPaymentDetails();

      expect(paymentDetailsNotifier.state.value, equals(testPaymentDetails));
      verify(mockRepo.getPaymentDetails(token: testToken)).called(1);
    });

    test('should set state to null when token does not exist', () async {
      when(mockPrefs.getString('auth_token')).thenReturn(null);

      await paymentDetailsNotifier.getPaymentDetails();

      expect(paymentDetailsNotifier.state.value, isNull);
      verifyNever(mockRepo.getPaymentDetails(token: anyNamed('token')));
    });

    test('should set state to error on fetch failure', () async {
      when(mockPrefs.getString('auth_token')).thenReturn(testToken);
      when(mockRepo.getPaymentDetails(token: testToken))
          .thenAnswer((_) async => null);

      await paymentDetailsNotifier.getPaymentDetails();

      expect(paymentDetailsNotifier.state.hasError, isTrue);
      verify(mockRepo.getPaymentDetails(token: testToken)).called(1);
    });
  });

  group('PendingPaymentsNotifier', () {
    const testToken = 'test_token';

    test('should initialize with null pending payments', () {
      expect(pendingPaymentsNotifier.state.value, isNull);
    });

    group('getPendingPayments', () {
      test('should update state with pending payments on successful fetch', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.getPendingPayments(token: testToken))
            .thenAnswer((_) async => testPendingPayments);

        await pendingPaymentsNotifier.getPendingPayments();

        expect(pendingPaymentsNotifier.state.value, equals(testPendingPayments));
        verify(mockRepo.getPendingPayments(token: testToken)).called(1);
      });

      test('should set state to null when token does not exist', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(null);

        await pendingPaymentsNotifier.getPendingPayments();

        expect(pendingPaymentsNotifier.state.value, isNull);
        verifyNever(mockRepo.getPendingPayments(token: anyNamed('token')));
      });

      test('should set state to error on fetch failure', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.getPendingPayments(token: testToken))
            .thenAnswer((_) async => null);

        await pendingPaymentsNotifier.getPendingPayments();

        expect(pendingPaymentsNotifier.state.hasError, isTrue);
        verify(mockRepo.getPendingPayments(token: testToken)).called(1);
      });
    });

    group('updatePaymentStatus', () {
      const userId = 'user_id_1';
      const status = 'approved';

      test('should update payment status and refresh pending payments on success', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).thenAnswer((_) async => true);
        when(mockRepo.getPendingPayments(token: testToken))
            .thenAnswer((_) async => testPendingPayments); // For refreshing

        // Set an initial state for pending payments so it can be refreshed
        pendingPaymentsNotifier.state = AsyncValue.data([]);

        final result = await pendingPaymentsNotifier.updatePaymentStatus(userId, status);

        expect(result, isTrue);
        expect(pendingPaymentsNotifier.state.value, equals(testPendingPayments));
        verify(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).called(1);
        verify(mockRepo.getPendingPayments(token: testToken)).called(1);
      });

      test('should return false and set error state if no token', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(null);

        final result = await pendingPaymentsNotifier.updatePaymentStatus(userId, status);

        expect(result, isFalse);
        expect(pendingPaymentsNotifier.state.hasError, isTrue);
        expect(pendingPaymentsNotifier.state.error.toString(), contains('Not logged in'));
        verifyNever(mockRepo.updatePaymentStatus(token: anyNamed('token'), userId: anyNamed('userId'), status: anyNamed('status')));
      });

      test('should return false and set error state on update failure', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).thenThrow(Exception('Failed to update status on backend'));

        // Set an initial state for pending payments
        pendingPaymentsNotifier.state = AsyncValue.data([]);

        final result = await pendingPaymentsNotifier.updatePaymentStatus(userId, status);

        expect(result, isFalse);
        expect(pendingPaymentsNotifier.state.hasError, isTrue);
        expect(pendingPaymentsNotifier.state.error.toString(), contains('Failed to update payment status: Exception: Failed to update status on backend'));
        verify(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).called(1);
        verifyNever(mockRepo.getPendingPayments(token: anyNamed('token')));
      });

      test('should return false and set error state on exception during update', () async {
        when(mockPrefs.getString('auth_token')).thenReturn(testToken);
        when(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).thenThrow(Exception('Network error'));

        // Set an initial state for pending payments
        pendingPaymentsNotifier.state = AsyncValue.data([]);

        final result = await pendingPaymentsNotifier.updatePaymentStatus(userId, status);

        expect(result, isFalse);
        expect(pendingPaymentsNotifier.state.hasError, isTrue);
        expect(pendingPaymentsNotifier.state.error.toString(), contains('Failed to update payment status'));
        verify(mockRepo.updatePaymentStatus(
          token: testToken,
          userId: userId,
          status: status,
        )).called(1);
        verifyNever(mockRepo.getPendingPayments(token: anyNamed('token')));
      });
    });
  });

  // Test the dioProvider as well, ensuring it provides a Dio instance
  test('dioProvider should provide a Dio instance', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final dio = container.read(dioProvider);
    expect(dio, isA<Dio>());
    expect(dio.options.baseUrl, 'http://localhost:5000/api');
  });

  // Test paymentRepositoryProvider as well
  test('paymentRepositoryProvider should provide a PaymentRepositoryNotifier', () {
    final container = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(Dio()), // Provide a dummy Dio instance
      paymentRepositoryProvider(Dio()).overrideWith(() => mockRepo), // Inject mock repo
      sharedPreferencesProvider.overrideWithValue(mockPrefs),
    ]);
    addTearDown(container.dispose);
    final repoNotifier = container.read(paymentRepositoryProvider(container.read(dioProvider)).notifier);
    expect(repoNotifier, isA<PaymentRepository>());
  });

  test('paymentRepositoryProvider.notifier should return PaymentRepository', () {
    final container = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(Dio()), // Provide a dummy Dio instance
      paymentRepositoryProvider(Dio()).overrideWith(() => mockRepo), // Inject mock repo
      sharedPreferencesProvider.overrideWithValue(mockPrefs),
    ]);
    addTearDown(container.dispose);
    final repo = container.read(paymentRepositoryProvider(container.read(dioProvider)).notifier);
    expect(repo, isA<PaymentRepository>());
  });

  test('userPaymentProvider should provide UserPaymentNotifier', () {
    final container = ProviderContainer(overrides: [
      paymentRepositoryProvider(Dio()).overrideWith(() => mockRepo), // Inject mock repo
      sharedPreferencesProvider.overrideWithValue(mockPrefs),
    ]);
    addTearDown(container.dispose);
    final notifier = container.read(userPaymentProvider.notifier);
    expect(notifier, isA<UserPaymentNotifier>());
  });

  test('paymentDetailsProvider should provide PaymentDetailsNotifier', () {
    final container = ProviderContainer(overrides: [
      paymentRepositoryProvider(Dio()).overrideWith(() => mockRepo), // Inject mock repo
      sharedPreferencesProvider.overrideWithValue(mockPrefs),
    ]);
    addTearDown(container.dispose);
    final notifier = container.read(paymentDetailsProvider.notifier);
    expect(notifier, isA<PaymentDetailsNotifier>());
  });

  test('pendingPaymentsProvider should provide PendingPaymentsNotifier', () {
    final container = ProviderContainer(overrides: [
      paymentRepositoryProvider(Dio()).overrideWith(() => mockRepo), // Inject mock repo
      sharedPreferencesProvider.overrideWithValue(mockPrefs),
    ]);
    addTearDown(container.dispose);
    final notifier = container.read(pendingPaymentsProvider.notifier);
    expect(notifier, isA<PendingPaymentsNotifier>());
  });
}
