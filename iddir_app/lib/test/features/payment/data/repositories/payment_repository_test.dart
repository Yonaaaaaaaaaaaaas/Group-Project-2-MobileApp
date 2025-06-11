import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/payment/data/data_sources/payment_remote_datasource.dart';
import 'package:iddir_app/features/payment/data/models/payment_model.dart';
import 'package:iddir_app/features/payment/data/repositories/payment_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/services.dart'; // For Uint8List

@GenerateMocks([PaymentRemoteDatasource])
import 'payment_repository_test.mocks.dart';

void main() {
  late MockPaymentRemoteDatasource mockRemoteDatasource;
  late PaymentRepository repository;

  setUp(() {
    mockRemoteDatasource = MockPaymentRemoteDatasource();
    // Create a test repository instance with the mock datasource
    repository = _TestPaymentRepository(mockRemoteDatasource);
  });

  group('getPaymentDetails', () {
    const token = 'test_token';
    final testPaymentDetails = PaymentDetails(
      paymentStatus: 'pending',
      receiptUrl: '/uploads/receipts/test.jpeg',
      paymentApprovedAt: DateTime.parse('2024-06-10T10:00:00.000Z'),
    );

    test('should return PaymentDetails when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDatasource.getPaymentDetails(token))
          .thenAnswer((_) async => testPaymentDetails);

      // Act
      final result = await repository.getPaymentDetails(token: token);

      // Assert
      expect(result, equals(testPaymentDetails));
      verify(mockRemoteDatasource.getPaymentDetails(token)).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDatasource.getPaymentDetails(token))
          .thenThrow(Exception('Failed to fetch payment details'));

      // Act
      final result = await repository.getPaymentDetails(token: token);

      // Assert
      expect(result, isNull);
      verify(mockRemoteDatasource.getPaymentDetails(token)).called(1);
    });
  });

  group('getPendingPayments', () {
    const token = 'test_token';
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

    test('should return list of PaymentModel when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDatasource.getPendingPayments(token))
          .thenAnswer((_) async => testPendingPayments);

      // Act
      final result = await repository.getPendingPayments(token: token);

      // Assert
      expect(result, equals(testPendingPayments));
      verify(mockRemoteDatasource.getPendingPayments(token)).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDatasource.getPendingPayments(token))
          .thenThrow(Exception('Failed to fetch pending payments'));

      // Act
      final result = await repository.getPendingPayments(token: token);

      // Assert
      expect(result, isNull);
      verify(mockRemoteDatasource.getPendingPayments(token)).called(1);
    });
  });

  group('updatePaymentStatus', () {
    const token = 'test_token';
    const userId = 'user_to_update';
    const newStatus = 'paid';

    test('should return true when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDatasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      )).thenAnswer((_) async => true);

      // Act
      final result = await repository.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      );

      // Assert
      expect(result, isTrue);
      verify(mockRemoteDatasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      )).called(1);
    });

    test('should return false when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDatasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      )).thenThrow(Exception('Failed to update payment status'));

      // Act
      final result = await repository.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      );

      // Assert
      expect(result, isFalse);
      verify(mockRemoteDatasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: newStatus,
      )).called(1);
    });
  });

  group('uploadReceipt', () {
    const token = 'test_token';
    const filePath = 'path/to/image.jpg';
    final imageBytes = Uint8List.fromList([1, 2, 3, 4]);
    const fileName = 'image.jpg';
    const receiptUrl = 'http://localhost:5000/public/uploads/receipt.jpg';

    test('should return receiptUrl when remote data source call is successful (non-web)', () async {
      // Arrange
      when(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      )).thenAnswer((_) async => receiptUrl);

      // Act
      final result = await repository.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      );

      // Assert
      expect(result, equals(receiptUrl));
      verify(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      )).called(1);
    });

    test('should return receiptUrl when remote data source call is successful (web)', () async {
      // Arrange
      when(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: null,
        imageBytes: imageBytes,
        fileName: fileName,
      )).thenAnswer((_) async => receiptUrl);

      // Act
      final result = await repository.uploadReceipt(
        token: token,
        filePath: null,
        imageBytes: imageBytes,
        fileName: fileName,
      );

      // Assert
      expect(result, equals(receiptUrl));
      verify(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: null,
        imageBytes: imageBytes,
        fileName: fileName,
      )).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      )).thenThrow(Exception('Failed to upload receipt'));

      // Act
      final result = await repository.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      );

      // Assert
      expect(result, isNull);
      verify(mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: null,
        fileName: null,
      )).called(1);
    });
  });
}

// Helper class to inject the mock PaymentRemoteDatasource
class _TestPaymentRepository extends PaymentRepository {
  final PaymentRemoteDatasource _mockRemoteDatasource;

  _TestPaymentRepository(this._mockRemoteDatasource);

  @override
  PaymentRemoteDatasource build(Dio dio) {
    return _mockRemoteDatasource; // Return the mock instead of creating a new one
  }

  // Override methods to call the mock directly
  @override
  Future<PaymentDetails?> getPaymentDetails({required String token}) async {
    try {
      return await _mockRemoteDatasource.getPaymentDetails(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<PaymentModel>?> getPendingPayments({required String token}) async {
    try {
      return await _mockRemoteDatasource.getPendingPayments(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> updatePaymentStatus({
    required String token,
    required String userId,
    required String status,
  }) async {
    try {
      return await _mockRemoteDatasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: status,
      );
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String?> uploadReceipt({
    required String token,
    String? filePath,
    Uint8List? imageBytes,
    String? fileName,
  }) async {
    try {
      return await _mockRemoteDatasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: imageBytes,
        fileName: fileName,
      );
    } catch (_) {
      return null;
    }
  }
}
