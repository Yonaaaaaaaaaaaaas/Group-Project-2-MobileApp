import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/users/data/models/users_model.dart';

void main() {
  group('UsersModel', () {
    test('should create a model with all fields', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '/images/profile.jpg',
        paymentStatus: 'pending',
        paymentReceipt: '/receipts/test.pdf',
        paymentApprovedAt: DateTime.parse('2024-03-20T10:00:00Z'),
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.id, equals('123'));
      expect(model.name, equals('Test User'));
      expect(model.email, equals('test@example.com'));
      expect(model.address, equals('123 Test St'));
      expect(model.phone, equals('1234567890'));
      expect(model.role, equals('user'));
      expect(model.profilePicture, equals('/images/profile.jpg'));
      expect(model.paymentStatus, equals('pending'));
      expect(model.paymentReceipt, equals('/receipts/test.pdf'));
      expect(model.paymentApprovedAt, equals(DateTime.parse('2024-03-20T10:00:00Z')));
      expect(model.createdAt, equals(DateTime.parse('2024-03-19T10:00:00Z')));
    });

    test('should create a model without optional fields', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.id, equals('123'));
      expect(model.name, equals('Test User'));
      expect(model.email, equals('test@example.com'));
      expect(model.address, equals('123 Test St'));
      expect(model.phone, equals('1234567890'));
      expect(model.role, equals('user'));
      expect(model.profilePicture, isNull);
      expect(model.paymentStatus, isNull);
      expect(model.paymentReceipt, isNull);
      expect(model.paymentApprovedAt, isNull);
      expect(model.createdAt, equals(DateTime.parse('2024-03-19T10:00:00Z')));
    });

    test('should serialize and deserialize JSON correctly', () {
      final json = {
        '_id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'address': '123 Test St',
        'phone': '1234567890',
        'role': 'user',
        'profilePicture': '/images/profile.jpg',
        'paymentStatus': 'pending',
        'paymentReceipt': '/receipts/test.pdf',
        'paymentApprovedAt': '2024-03-20T10:00:00.000Z',
        'createdAt': '2024-03-19T10:00:00.000Z',
      };

      final model = UsersModel.fromJson(json);
      final serialized = model.toJson();

      // Compare each field individually to handle DateTime format differences
      expect(serialized['_id'], equals(json['_id']));
      expect(serialized['name'], equals(json['name']));
      expect(serialized['email'], equals(json['email']));
      expect(serialized['address'], equals(json['address']));
      expect(serialized['phone'], equals(json['phone']));
      expect(serialized['role'], equals(json['role']));
      expect(serialized['profilePicture'], equals(json['profilePicture']));
      expect(serialized['paymentStatus'], equals(json['paymentStatus']));
      expect(serialized['paymentReceipt'], equals(json['paymentReceipt']));
      
      // For DateTime fields, compare the parsed values
      expect(
        DateTime.parse(serialized['paymentApprovedAt'] as String),
        equals(DateTime.parse(json['paymentApprovedAt'] as String)),
      );
      expect(
        DateTime.parse(serialized['createdAt'] as String),
        equals(DateTime.parse(json['createdAt'] as String)),
      );
    });

    test('should serialize and deserialize JSON without optional fields', () {
      final json = {
        '_id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'address': '123 Test St',
        'phone': '1234567890',
        'role': 'user',
        'createdAt': '2024-03-19T10:00:00.000Z',
      };

      final model = UsersModel.fromJson(json);
      final serialized = model.toJson();

      // Compare each field individually
      expect(serialized['_id'], equals(json['_id']));
      expect(serialized['name'], equals(json['name']));
      expect(serialized['email'], equals(json['email']));
      expect(serialized['address'], equals(json['address']));
      expect(serialized['phone'], equals(json['phone']));
      expect(serialized['role'], equals(json['role']));
      expect(serialized['createdAt'], equals(json['createdAt']));

      // Verify optional fields are null
      expect(serialized['profilePicture'], isNull);
      expect(serialized['paymentStatus'], isNull);
      expect(serialized['paymentReceipt'], isNull);
      expect(serialized['paymentApprovedAt'], isNull);
    });

    test('should handle JSON with _id field', () {
      final json = {
        '_id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'address': '123 Test St',
        'phone': '1234567890',
        'role': 'user',
        'createdAt': '2024-03-19T10:00:00.000Z',
      };

      final model = UsersModel.fromJson(json);

      expect(model.id, equals('123')); // Should map _id to id
    });
  });

  group('UsersModelExtension', () {
    test('should generate correct full profile picture URL', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '/images/profile.jpg',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.fullProfilePictureUrl,
          equals('http://localhost:5000/public/images/profile.jpg'));
    });

    test('should handle backslashes in profile picture path', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '\\images\\profile.jpg',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.fullProfilePictureUrl,
          equals('http://localhost:5000/public/images/profile.jpg'));
    });

    test('should return null when profile picture is null', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.fullProfilePictureUrl, isNull);
    });

    test('should handle empty profile picture path', () {
      final model = UsersModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      expect(model.fullProfilePictureUrl,
          equals('http://localhost:5000/public'));
    });
  });
}
