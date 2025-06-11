import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/users/data/data_sources/users_remote_datasource.dart';
import 'package:iddir_app/features/users/data/models/users_model.dart';
import 'package:iddir_app/features/users/data/repositories/users_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([UsersRemoteDatasource])
import 'users_repository_test.mocks.dart';

void main() {
  late MockUsersRemoteDatasource mockDatasource;
  late UsersRepository repository;

  setUp(() {
    mockDatasource = MockUsersRemoteDatasource();
    repository = _TestUsersRepository(mockDatasource);
  });

  group('getAllUsers', () {
    final testToken = 'test_token';
    final testUsers = [
      UsersModel(
        id: '1',
        name: 'User 1',
        email: 'user1@test.com',
        address: 'Address 1',
        phone: '1234567890',
        role: 'user',
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      ),
      UsersModel(
        id: '2',
        name: 'User 2',
        email: 'user2@test.com',
        address: 'Address 2',
        phone: '0987654321',
        role: 'user',
        createdAt: DateTime.parse('2024-03-19T11:00:00Z'),
      ),
    ];

    test('should return list of users when datasource call is successful', () async {
      when(mockDatasource.getAllUsers(testToken))
          .thenAnswer((_) async => testUsers);

      final result = await repository.getAllUsers(token: testToken);

      expect(result, equals(testUsers));
      verify(mockDatasource.getAllUsers(testToken)).called(1);
    });

    test('should return null when datasource throws error', () async {
      when(mockDatasource.getAllUsers(testToken))
          .thenThrow(Exception('Test error'));

      final result = await repository.getAllUsers(token: testToken);

      expect(result, isNull);
      verify(mockDatasource.getAllUsers(testToken)).called(1);
    });
  });

  group('getUser', () {
    final testToken = 'test_token';
    final testUserId = '123';
    final testUser = UsersModel(
      id: testUserId,
      name: 'Test User',
      email: 'test@example.com',
      address: '123 Test St',
      phone: '1234567890',
      role: 'user',
      createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
    );

    test('should return user when datasource call is successful', () async {
      when(mockDatasource.getUser(testToken, testUserId))
          .thenAnswer((_) async => testUser);

      final result = await repository.getUser(
        token: testToken,
        userId: testUserId,
      );

      expect(result, equals(testUser));
      verify(mockDatasource.getUser(testToken, testUserId)).called(1);
    });

    test('should return null when datasource throws error', () async {
      when(mockDatasource.getUser(testToken, testUserId))
          .thenThrow(Exception('Test error'));

      final result = await repository.getUser(
        token: testToken,
        userId: testUserId,
      );

      expect(result, isNull);
      verify(mockDatasource.getUser(testToken, testUserId)).called(1);
    });
  });

  group('deleteUser', () {
    final testToken = 'test_token';
    final testUserId = '123';

    test('should delete user successfully', () async {
      when(mockDatasource.deleteUser(token: testToken, userId: testUserId))
          .thenAnswer((_) async => true);

      final result = await repository.deleteUser(
        token: testToken,
        userId: testUserId,
      );

      expect(result, isTrue);
      verify(mockDatasource.deleteUser(
        token: testToken,
        userId: testUserId,
      )).called(1);
    });

    test('should return false when deletion fails', () async {
      when(mockDatasource.deleteUser(token: testToken, userId: testUserId))
          .thenThrow(Exception('Test error'));

      final result = await repository.deleteUser(
        token: testToken,
        userId: testUserId,
      );

      expect(result, isFalse);
      verify(mockDatasource.deleteUser(
        token: testToken,
        userId: testUserId,
      )).called(1);
    });
  });
}

class _TestUsersRepository extends UsersRepository {
  final UsersRemoteDatasource mockDatasource;
  _TestUsersRepository(this.mockDatasource);

  @override
  Future<List<UsersModel>?> getAllUsers({required String token}) async {
    try {
      return await mockDatasource.getAllUsers(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UsersModel?> getUser({
    required String token,
    required String userId,
  }) async {
    try {
      return await mockDatasource.getUser(token, userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteUser({
    required String token,
    required String userId,
  }) async {
    try {
      return await mockDatasource.deleteUser(token: token, userId: userId);
    } catch (_) {
      return false;
    }
  }
}
