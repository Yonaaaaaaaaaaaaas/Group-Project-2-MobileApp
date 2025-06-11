import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/users/data/data_sources/users_remote_datasource.dart';
import 'package:iddir_app/features/users/data/models/users_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'users_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, BaseOptions])
void main() {
  late UsersRemoteDatasource dataSource;
  late MockDio mockDio;
  late MockBaseOptions mockBaseOptions;

  setUp(() {
    mockDio = MockDio();
    mockBaseOptions = MockBaseOptions();
    when(mockDio.options).thenReturn(mockBaseOptions);
    when(mockBaseOptions.baseUrl).thenReturn('http://localhost:5000');
    dataSource = UsersRemoteDatasource(mockDio);
  });

  group('getAllUsers', () {
    const token = 'test_token';
    final testUsers = [
      {
        '_id': '1',
        'name': 'User 1',
        'email': 'user1@test.com',
        'address': 'Address 1',
        'phone': '1234567890',
        'role': 'user',
        'createdAt': '2024-03-19T10:00:00.000Z',
      },
      {
        '_id': '2',
        'name': 'User 2',
        'email': 'user2@test.com',
        'address': 'Address 2',
        'phone': '0987654321',
        'role': 'user',
        'createdAt': '2024-03-19T11:00:00.000Z',
      },
    ];

    test('should return list of users when API call is successful', () async {
      // arrange
      when(mockDio.get(
        '/users',
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: testUsers,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/users'),
      ));

      // act
      final result = await dataSource.getAllUsers(token);

      // assert
      expect(result, isA<List<UsersModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('2'));
      verify(mockDio.get(
        '/users',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw error when API call fails with DioException', () async {
      // arrange
      when(mockDio.get(
        '/users',
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/users'),
        error: 'Network error',
      ));

      // act & assert
      expect(
        () => dataSource.getAllUsers(token),
        throwsA(contains('Failed to get users data')),
      );
      verify(mockDio.get(
        '/users',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when unexpected error occurs', () async {
      // arrange
      when(mockDio.get(
        '/users',
        options: anyNamed('options'),
      )).thenThrow(Exception('Unexpected error'));

      // act & assert
      expect(
        () => dataSource.getAllUsers(token),
        throwsA(equals('An unexpected error occurred')),
      );
      verify(mockDio.get(
        '/users',
        options: anyNamed('options'),
      )).called(1);
    });
  });

  group('getUser', () {
    const token = 'test_token';
    const userId = '123';
    final testUser = {
      '_id': userId,
      'name': 'Test User',
      'email': 'test@example.com',
      'address': '123 Test St',
      'phone': '1234567890',
      'role': 'user',
      'createdAt': '2024-03-19T10:00:00.000Z',
    };

    test('should return user when API call is successful', () async {
      // arrange
      when(mockDio.get(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: testUser,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/users/$userId'),
      ));

      // act
      final result = await dataSource.getUser(token, userId);

      // assert
      expect(result, isA<UsersModel>());
      expect(result.id, equals(userId));
      expect(result.name, equals('Test User'));
      verify(mockDio.get(
        '/users/$userId',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw error when API call fails with DioException', () async {
      // arrange
      when(mockDio.get(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/users/$userId'),
        error: 'Network error',
      ));

      // act & assert
      expect(
        () => dataSource.getUser(token, userId),
        throwsA(contains('Failed to get user data')),
      );
      verify(mockDio.get(
        '/users/$userId',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when unexpected error occurs', () async {
      // arrange
      when(mockDio.get(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenThrow(Exception('Unexpected error'));

      // act & assert
      expect(
        () => dataSource.getUser(token, userId),
        throwsA(equals('An unexpected error occurred')),
      );
      verify(mockDio.get(
        '/users/$userId',
        options: anyNamed('options'),
      )).called(1);
    });
  });

  group('deleteUser', () {
    const token = 'test_token';
    const userId = '123';

    test('should return true when API call is successful', () async {
      // arrange
      when(mockDio.delete(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: {'message': 'User deleted successfully'},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/users/$userId'),
      ));

      // act
      final result = await dataSource.deleteUser(token: token, userId: userId);

      // assert
      expect(result, isTrue);
      verify(mockDio.delete(
        '/users/$userId',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw error when API call fails with DioException', () async {
      // arrange
      when(mockDio.delete(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/users/$userId'),
        error: 'Network error',
      ));

      // act & assert
      expect(
        () => dataSource.deleteUser(token: token, userId: userId),
        throwsA(contains('Failed to delete user')),
      );
      verify(mockDio.delete(
        '/users/$userId',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when unexpected error occurs', () async {
      // arrange
      when(mockDio.delete(
        '/users/$userId',
        options: anyNamed('options'),
      )).thenThrow(Exception('Unexpected error'));

      // act & assert
      expect(
        () => dataSource.deleteUser(token: token, userId: userId),
        throwsA(equals('An unexpected error occurred')),
      );
      verify(mockDio.delete(
        '/users/$userId',
        options: anyNamed('options'),
      )).called(1);
    });
  });
}
