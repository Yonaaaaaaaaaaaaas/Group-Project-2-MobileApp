import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/profile/data/models/profile_model.dart';

void main() {
  group('ProfileModel', () {
    final testProfile = ProfileModel(
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
    );

    final testProfileWithoutOptionals = ProfileModel(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
      address: '123 Test St',
      phone: '1234567890',
      role: 'user',
    );

    test('should create ProfileModel with all fields', () {
      expect(testProfile.id, equals('123'));
      expect(testProfile.name, equals('Test User'));
      expect(testProfile.email, equals('test@example.com'));
      expect(testProfile.address, equals('123 Test St'));
      expect(testProfile.phone, equals('1234567890'));
      expect(testProfile.role, equals('user'));
      expect(testProfile.profilePicture, equals('/images/profile.jpg'));
      expect(testProfile.paymentStatus, equals('pending'));
      expect(testProfile.paymentReceipt, equals('/receipts/test.pdf'));
      expect(testProfile.paymentApprovedAt, equals(DateTime.parse('2024-03-20T10:00:00Z')));
    });

    test('should create ProfileModel without optional fields', () {
      expect(testProfileWithoutOptionals.id, equals('123'));
      expect(testProfileWithoutOptionals.name, equals('Test User'));
      expect(testProfileWithoutOptionals.email, equals('test@example.com'));
      expect(testProfileWithoutOptionals.address, equals('123 Test St'));
      expect(testProfileWithoutOptionals.phone, equals('1234567890'));
      expect(testProfileWithoutOptionals.role, equals('user'));
      expect(testProfileWithoutOptionals.profilePicture, isNull);
      expect(testProfileWithoutOptionals.paymentStatus, isNull);
      expect(testProfileWithoutOptionals.paymentReceipt, isNull);
      expect(testProfileWithoutOptionals.paymentApprovedAt, isNull);
    });

    test('should convert ProfileModel to JSON and back', () {
      final json = testProfile.toJson();
      final fromJson = ProfileModel.fromJson(json);

      expect(fromJson, equals(testProfile));
      expect(fromJson.id, equals(testProfile.id));
      expect(fromJson.name, equals(testProfile.name));
      expect(fromJson.email, equals(testProfile.email));
      expect(fromJson.address, equals(testProfile.address));
      expect(fromJson.phone, equals(testProfile.phone));
      expect(fromJson.role, equals(testProfile.role));
      expect(fromJson.profilePicture, equals(testProfile.profilePicture));
      expect(fromJson.paymentStatus, equals(testProfile.paymentStatus));
      expect(fromJson.paymentReceipt, equals(testProfile.paymentReceipt));
      expect(fromJson.paymentApprovedAt, equals(testProfile.paymentApprovedAt));
    });

    test('should convert ProfileModel without optionals to JSON and back', () {
      final json = testProfileWithoutOptionals.toJson();
      final fromJson = ProfileModel.fromJson(json);

      expect(fromJson, equals(testProfileWithoutOptionals));
      expect(fromJson.id, equals(testProfileWithoutOptionals.id));
      expect(fromJson.name, equals(testProfileWithoutOptionals.name));
      expect(fromJson.email, equals(testProfileWithoutOptionals.email));
      expect(fromJson.address, equals(testProfileWithoutOptionals.address));
      expect(fromJson.phone, equals(testProfileWithoutOptionals.phone));
      expect(fromJson.role, equals(testProfileWithoutOptionals.role));
      expect(fromJson.profilePicture, isNull);
      expect(fromJson.paymentStatus, isNull);
      expect(fromJson.paymentReceipt, isNull);
      expect(fromJson.paymentApprovedAt, isNull);
    });

    test('should handle JSON with _id field', () {
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
        'paymentApprovedAt': '2024-03-20T10:00:00Z',
      };

      final profile = ProfileModel.fromJson(json);

      expect(profile.id, equals('123'));
      expect(profile.name, equals('Test User'));
      expect(profile.email, equals('test@example.com'));
      expect(profile.address, equals('123 Test St'));
      expect(profile.phone, equals('1234567890'));
      expect(profile.role, equals('user'));
      expect(profile.profilePicture, equals('/images/profile.jpg'));
      expect(profile.paymentStatus, equals('pending'));
      expect(profile.paymentReceipt, equals('/receipts/test.pdf'));
      expect(profile.paymentApprovedAt, equals(DateTime.parse('2024-03-20T10:00:00Z')));
    });
  });

  group('ProfileModelExtension', () {
    test('should generate correct full profile picture URL', () {
      final profile = ProfileModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '/images/profile.jpg',
      );

      expect(profile.fullProfilePictureUrl, equals('http://localhost:5000/public/images/profile.jpg'));
    });

    test('should handle backslashes in profile picture path', () {
      final profile = ProfileModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '\\images\\profile.jpg',
      );

      expect(profile.fullProfilePictureUrl, equals('http://localhost:5000/public/images/profile.jpg'));
    });

    test('should return null when profile picture is null', () {
      final profile = ProfileModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
      );

      expect(profile.fullProfilePictureUrl, isNull);
    });

    test('should handle empty profile picture path', () {
      final profile = ProfileModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        address: '123 Test St',
        phone: '1234567890',
        role: 'user',
        profilePicture: '',
      );

      expect(profile.fullProfilePictureUrl, equals('http://localhost:5000/public'));
    });
  });
}
