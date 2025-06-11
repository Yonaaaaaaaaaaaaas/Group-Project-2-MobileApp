import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/auth/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create a UserModel from JSON', () {
      // Arrange
      final json = {
        'id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'role': 'user',
      };

      // Act
      final user = UserModel.fromJson(json);

      // Assert
      expect(user.id, equals('123'));
      expect(user.name, equals('Test User'));
      expect(user.email, equals('test@example.com'));
      expect(user.role, equals('user'));
    });

    test('should convert UserModel to JSON', () {
      // Arrange
      final user = UserModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: 'user',
      );

      // Act
      final json = user.toJson();

      // Assert
      expect(json['id'], equals('123'));
      expect(json['name'], equals('Test User'));
      expect(json['email'], equals('test@example.com'));
      expect(json['role'], equals('user'));
    });

    test('should handle empty values', () {
      // Arrange
      final json = {
        'id': '',
        'name': '',
        'email': '',
        'role': '',
      };

      // Act
      final user = UserModel.fromJson(json);

      // Assert
      expect(user.id, isEmpty);
      expect(user.name, isEmpty);
      expect(user.email, isEmpty);
      expect(user.role, isEmpty);
    });
  });
}
