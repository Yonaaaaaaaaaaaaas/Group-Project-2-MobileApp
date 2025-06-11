import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/payment/data/models/payment_model.dart';

void main() {
  group('PaymentModel', () {
    test('should create a model with all fields', () {
      final model = PaymentModel(
        id: 'pay123',
        name: 'User A',
        email: 'user.a@example.com',
        paymentStatus: 'pending',
        paymentReceipt: '\\uploads\\receipts\\receipt.jpeg',
        paymentApprovedAt: DateTime.parse('2024-06-10T10:00:00Z'),
        createdAt: DateTime.parse('2024-06-09T10:00:00Z'),
      );

      expect(model.id, 'pay123');
      expect(model.name, 'User A');
      expect(model.email, 'user.a@example.com');
      expect(model.paymentStatus, 'pending');
      expect(model.paymentReceipt, '\\uploads\\receipts\\receipt.jpeg');
      expect(model.paymentApprovedAt, DateTime.parse('2024-06-10T10:00:00Z'));
      expect(model.createdAt, DateTime.parse('2024-06-09T10:00:00Z'));
    });

    test('should create a model with optional fields as null', () {
      final model = PaymentModel(
        id: 'pay456',
        name: 'User B',
        email: 'user.b@example.com',
        paymentStatus: 'paid',
        paymentReceipt: null,
        paymentApprovedAt: null,
        createdAt: DateTime.parse('2024-06-08T10:00:00Z'),
      );

      expect(model.id, 'pay456');
      expect(model.name, 'User B');
      expect(model.email, 'user.b@example.com');
      expect(model.paymentStatus, 'paid');
      expect(model.paymentReceipt, isNull);
      expect(model.paymentApprovedAt, isNull);
      expect(model.createdAt, DateTime.parse('2024-06-08T10:00:00Z'));
    });

    test('should serialize and deserialize JSON correctly with all fields', () {
      final json = {
        '_id': 'pay789',
        'name': 'User C',
        'email': 'user.c@example.com',
        'paymentStatus': 'pending',
        'paymentReceipt': '\\uploads\\receipts\\receipt2.jpeg',
        'paymentApprovedAt': '2024-06-12T10:00:00.000Z',
        'createdAt': '2024-06-11T10:00:00.000Z',
      };

      final model = PaymentModel.fromJson(json);
      final serialized = model.toJson();

      expect(model.id, 'pay789');
      expect(model.name, 'User C');
      expect(model.paymentStatus, 'pending');
      expect(model.paymentApprovedAt, DateTime.parse('2024-06-12T10:00:00Z'));

      expect(serialized['_id'], json['_id']);
      expect(serialized['name'], json['name']);
      expect(serialized['email'], json['email']);
      expect(serialized['paymentStatus'], json['paymentStatus']);
      expect(serialized['paymentReceipt'], json['paymentReceipt']);
      expect(serialized['paymentApprovedAt'], json['paymentApprovedAt']);
      expect(serialized['createdAt'], json['createdAt']);
    });

    test('should serialize and deserialize JSON correctly with optional fields as null', () {
      final json = {
        '_id': 'pay101',
        'name': 'User D',
        'email': 'user.d@example.com',
        'paymentStatus': 'unpaid',
        'createdAt': '2024-06-13T10:00:00.000Z',
      };

      final model = PaymentModel.fromJson(json);
      final serialized = model.toJson();

      expect(model.id, 'pay101');
      expect(model.name, 'User D');
      expect(model.paymentStatus, 'unpaid');
      expect(model.paymentReceipt, isNull);
      expect(model.paymentApprovedAt, isNull);

      expect(serialized['_id'], json['_id']);
      expect(serialized['name'], json['name']);
      expect(serialized['email'], json['email']);
      expect(serialized['paymentStatus'], json['paymentStatus']);
      expect(serialized['paymentReceipt'], isNull); // Verify null in serialized
      expect(serialized['paymentApprovedAt'], isNull); // Verify null in serialized
      expect(serialized['createdAt'], json['createdAt']);
    });

    test('should handle JSON with _id field mapping to id', () {
      final json = {
        '_id': 'testId',
        'name': 'Test User',
        'email': 'test@test.com',
        'paymentStatus': 'pending',
        'createdAt': '2024-01-01T00:00:00Z',
      };
      final model = PaymentModel.fromJson(json);
      expect(model.id, 'testId');
    });
  });

  group('PaymentDetails', () {
    test('should create a model with all fields', () {
      final model = PaymentDetails(
        paymentStatus: 'paid',
        receiptUrl: 'receipt_url_example',
        paymentApprovedAt: DateTime.parse('2024-06-10T15:00:00Z'),
      );

      expect(model.paymentStatus, 'paid');
      expect(model.receiptUrl, 'receipt_url_example');
      expect(model.paymentApprovedAt, DateTime.parse('2024-06-10T15:00:00Z'));
    });

    test('should serialize and deserialize JSON correctly', () {
      final json = {
        'paymentStatus': 'pending',
        'receiptUrl': 'some_receipt.jpg',
        'paymentApprovedAt': '2024-06-10T15:00:00.000Z',
      };

      final model = PaymentDetails.fromJson(json);
      final serialized = model.toJson();

      expect(model.paymentStatus, 'pending');
      expect(model.receiptUrl, 'some_receipt.jpg');

      expect(serialized['paymentStatus'], json['paymentStatus']);
      expect(serialized['receiptUrl'], json['receiptUrl']);
      expect(serialized['paymentApprovedAt'], json['paymentApprovedAt']);
    });

    test('should handle null optional fields in PaymentDetails', () {
      final json = {
        'paymentStatus': 'unpaid',
      };

      final model = PaymentDetails.fromJson(json);
      expect(model.paymentStatus, 'unpaid');
      expect(model.receiptUrl, isNull);
      expect(model.paymentApprovedAt, isNull);

      final serialized = model.toJson();
      expect(serialized['paymentStatus'], json['paymentStatus']);
      expect(serialized['receiptUrl'], isNull);
      expect(serialized['paymentApprovedAt'], isNull);
    });
  });

  group('PaymentStatistics', () {
    test('should create a model with all fields', () {
      final model = PaymentStatistics(
        inBank: 10000.0,
        overdue: 5000.0,
        pending: 2000.0,
      );

      expect(model.inBank, 10000.0);
      expect(model.overdue, 5000.0);
      expect(model.pending, 2000.0);
    });

    test('should serialize and deserialize JSON correctly', () {
      final json = {
        'inBank': 15000.0,
        'overdue': 7500.0,
        'pending': 3000.0,
      };

      final model = PaymentStatistics.fromJson(json);
      final serialized = model.toJson();

      expect(model.inBank, 15000.0);
      expect(model.overdue, 7500.0);
      expect(model.pending, 3000.0);

      expect(serialized['inBank'], json['inBank']);
      expect(serialized['overdue'], json['overdue']);
      expect(serialized['pending'], json['pending']);
    });
  });

  group('PaymentModelExtension', () {
    const baseUrl = 'http://localhost:5000';

    test('should generate correct fullReceiptUrl for valid path with backslashes', () {
      final model = PaymentModel(
        id: '1',
        name: 'User',
        email: 'user@test.com',
        paymentStatus: 'pending',
        paymentReceipt: '\\uploads\\receipts\\receipt-123.jpeg',
        createdAt: DateTime.now(),
      );
      expect(model.fullReceiptUrl, '$baseUrl/public/uploads/receipts/receipt-123.jpeg');
    });

    test('should generate correct fullReceiptUrl for valid path with forward slashes', () {
      final model = PaymentModel(
        id: '2',
        name: 'User',
        email: 'user@test.com',
        paymentStatus: 'pending',
        paymentReceipt: '/uploads/receipts/receipt-456.png',
        createdAt: DateTime.now(),
      );
      expect(model.fullReceiptUrl, '$baseUrl/public/uploads/receipts/receipt-456.png');
    });

    test('should return null when paymentReceipt is null', () {
      final model = PaymentModel(
        id: '3',
        name: 'User',
        email: 'user@test.com',
        paymentStatus: 'pending',
        paymentReceipt: null,
        createdAt: DateTime.now(),
      );
      expect(model.fullReceiptUrl, isNull);
    });

    test('should handle empty paymentReceipt path', () {
      final model = PaymentModel(
        id: '4',
        name: 'User',
        email: 'user@test.com',
        paymentStatus: 'pending',
        paymentReceipt: '',
        createdAt: DateTime.now(),
      );
      expect(model.fullReceiptUrl, '$baseUrl/public/'); // Base URL with public, as no specific file
    });

    test('should handle paymentReceipt with leading slash', () {
      final model = PaymentModel(
        id: '5',
        name: 'User',
        email: 'user@test.com',
        paymentStatus: 'pending',
        paymentReceipt: '/path/to/image.jpg',
        createdAt: DateTime.now(),
      );
      expect(model.fullReceiptUrl, '$baseUrl/public/path/to/image.jpg');
    });
  });
}
