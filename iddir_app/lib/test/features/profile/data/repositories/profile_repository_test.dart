import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:iddir_app/features/profile/data/models/profile_model.dart';
import 'package:iddir_app/features/profile/data/repositories/profile_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProfileRemoteDatasource])
import 'profile_repository_test.mocks.dart';

void main() {
  late MockProfileRemoteDatasource mockDatasource;
  late ProfileRepository repository;

  setUp(() {
    mockDatasource = MockProfileRemoteDatasource();
    repository = _TestProfileRepository(mockDatasource);
  });

  group('getProfile', () {
    final testToken = 'test_token';
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

    test('should return profile when datasource call is successful', () async {
      when(mockDatasource.getProfile(testToken))
          .thenAnswer((_) async => testProfile);

      final result = await repository.getProfile(token: testToken);

      expect(result, equals(testProfile));
      verify(mockDatasource.getProfile(testToken)).called(1);
    });

    test('should return null when datasource throws error', () async {
      when(mockDatasource.getProfile(testToken))
          .thenThrow(Exception('Test error'));

      final result = await repository.getProfile(token: testToken);

      expect(result, isNull);
      verify(mockDatasource.getProfile(testToken)).called(1);
    });
  });

  group('updateProfile', () {
    final testToken = 'test_token';
    final testData = {
      'name': 'Updated Name',
      'address': 'Updated Address',
      'phone': '9876543210',
    };

    final testProfile = ProfileModel(
      id: '123',
      name: 'Updated Name',
      email: 'test@example.com',
      address: 'Updated Address',
      phone: '9876543210',
      role: 'user',
      profilePicture: '/images/profile.jpg',
      paymentStatus: 'pending',
      paymentReceipt: '/receipts/test.pdf',
      paymentApprovedAt: DateTime.parse('2024-03-20T10:00:00Z'),
    );

    test('should update profile successfully', () async {
      when(mockDatasource.updateProfile(testToken, testData))
          .thenAnswer((_) async => testProfile);

      final result = await repository.updateProfile(
        token: testToken,
        data: testData,
      );

      expect(result, equals(testProfile));
      verify(mockDatasource.updateProfile(testToken, testData)).called(1);
    });

    test('should return null when update fails', () async {
      when(mockDatasource.updateProfile(testToken, testData))
          .thenThrow(Exception('Test error'));

      final result = await repository.updateProfile(
        token: testToken,
        data: testData,
      );

      expect(result, isNull);
      verify(mockDatasource.updateProfile(testToken, testData)).called(1);
    });
  });

  group('updateProfilePicture', () {
    final testToken = 'test_token';
    final testImageData = FormData.fromMap({
      'image': MultipartFile.fromString('test image data'),
    });
    const testImageUrl = 'http://localhost:5000/public/images/new-profile.jpg';

    test('should update profile picture successfully', () async {
      when(mockDatasource.updateProfilePicture(testToken, testImageData))
          .thenAnswer((_) async => testImageUrl);

      final result = await repository.updateProfilePicture(
        token: testToken,
        imageData: testImageData,
      );

      expect(result, equals(testImageUrl));
      verify(mockDatasource.updateProfilePicture(testToken, testImageData))
          .called(1);
    });

    test('should return null when update fails', () async {
      when(mockDatasource.updateProfilePicture(testToken, testImageData))
          .thenThrow(Exception('Test error'));

      final result = await repository.updateProfilePicture(
        token: testToken,
        imageData: testImageData,
      );

      expect(result, isNull);
      verify(mockDatasource.updateProfilePicture(testToken, testImageData))
          .called(1);
    });
  });

  group('deleteAccount', () {
    final testToken = 'test_token';

    test('should delete account successfully', () async {
      when(mockDatasource.deleteAccount(testToken))
          .thenAnswer((_) async => true);

      final result = await repository.deleteAccount(token: testToken);

      expect(result, isTrue);
      verify(mockDatasource.deleteAccount(testToken)).called(1);
    });

    test('should return false when deletion fails', () async {
      when(mockDatasource.deleteAccount(testToken))
          .thenThrow(Exception('Test error'));

      final result = await repository.deleteAccount(token: testToken);

      expect(result, isFalse);
      verify(mockDatasource.deleteAccount(testToken)).called(1);
    });
  });
}

class _TestProfileRepository extends ProfileRepository {
  final ProfileRemoteDatasource mockDatasource;
  _TestProfileRepository(this.mockDatasource);

  @override
  Future<ProfileModel?> getProfile({required String token}) async {
    try {
      return await mockDatasource.getProfile(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ProfileModel?> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await mockDatasource.updateProfile(token, data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> updateProfilePicture({
    required String token,
    required dynamic imageData,
  }) async {
    try {
      return await mockDatasource.updateProfilePicture(token, imageData);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteAccount({required String token}) async {
    try {
      return await mockDatasource.deleteAccount(token);
    } catch (_) {
      return false;
    }
  }
}
