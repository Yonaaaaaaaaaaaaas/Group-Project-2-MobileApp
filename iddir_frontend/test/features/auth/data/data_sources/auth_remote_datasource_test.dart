import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:iddir_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:iddir_app/features/auth/data/models/user_model.dart';

@GenerateMocks([Dio])
import 'auth_remote_datasource_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthRemoteDatasource datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = AuthRemoteDatasource(mockDio);
  });

  group('AuthRemoteDatasource - login', () {
    const email = 'test@example.com';
    const password = 'password123';
    final loginData = {'email': email, 'password': password};
    final successResponse = {
      'token': 'test_token',
      'user': {
        'id': '123',
        'name': 'Test User',
        'email': email,
        'role': 'user',
      },
    };

    test('should return login response on successful login', () async {
      // Arrange
      when(mockDio.post(
        '/auth/login',
        data: loginData,
      )).thenAnswer((_) async => Response(
        data: successResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/login'),
      ));

      // Act
      final result = await datasource.login(email, password);

      // Assert
      expect(result, equals(successResponse));
      verify(mockDio.post(
        '/auth/login',
        data: loginData,
      )).called(1);
    });

    test('should throw "Invalid email or password" on 401 status code', () async {
      // Arrange
      when(mockDio.post(
        '/auth/login',
        data: loginData,
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/auth/login'),
        ),
      ));

      // Act & Assert
      expect(
        () => datasource.login(email, password),
        throwsA('Invalid email or password'),
      );
      verify(mockDio.post(
        '/auth/login',
        data: loginData,
      )).called(1);
    });

    test('should throw error message on other DioException', () async {
      // Arrange
      const errorMessage = 'Network error';
      when(mockDio.post(
        '/auth/login',
        data: loginData,
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        message: errorMessage,
      ));

      // Act & Assert
      expect(
        () => datasource.login(email, password),
        throwsA('Login failed: $errorMessage'),
      );
      verify(mockDio.post(
        '/auth/login',
        data: loginData,
      )).called(1);
    });

    test('should throw unexpected error message on non-DioException', () async {
      // Arrange
      when(mockDio.post(
        '/auth/login',
        data: loginData,
      )).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => datasource.login(email, password),
        throwsA('An unexpected error occurred'),
      );
      verify(mockDio.post(
        '/auth/login',
        data: loginData,
      )).called(1);
    });
  });

  group('AuthRemoteDatasource - register', () {
    final registerData = {
      'name': 'Test User',
      'email': 'test@example.com',
      'password': 'password123',
    };
    final successResponse = {
      'token': 'test_token',
      'user': {
        'id': '123',
        'name': registerData['name'],
        'email': registerData['email'],
        'role': 'user',
      },
    };

    test('should return register response on successful registration', () async {
      // Arrange
      when(mockDio.post(
        '/auth/register',
        data: registerData,
      )).thenAnswer((_) async => Response(
        data: successResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/register'),
      ));

      // Act
      final result = await datasource.register(registerData);

      // Assert
      expect(result, equals(successResponse));
      verify(mockDio.post(
        '/auth/register',
        data: registerData,
      )).called(1);
    });

    test('should throw error message on DioException', () async {
      // Arrange
      const errorMessage = 'Email already exists';
      when(mockDio.post(
        '/auth/register',
        data: registerData,
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/register'),
        message: errorMessage,
      ));

      // Act & Assert
      expect(
        () => datasource.register(registerData),
        throwsA('Registration failed: $errorMessage'),
      );
      verify(mockDio.post(
        '/auth/register',
        data: registerData,
      )).called(1);
    });

    test('should throw unexpected error message on non-DioException', () async {
      // Arrange
      when(mockDio.post(
        '/auth/register',
        data: registerData,
      )).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => datasource.register(registerData),
        throwsA('An unexpected error occurred'),
      );
      verify(mockDio.post(
        '/auth/register',
        data: registerData,
      )).called(1);
    });
  });

  group('AuthRemoteDatasource - getMe', () {
    const token = 'test_token';
    final successResponse = {
      'id': '123',
      'name': 'Test User',
      'email': 'test@example.com',
      'role': 'user',
    };

    test('should return UserModel on successful getMe', () async {
      // Arrange
      when(mockDio.get(
        '/auth/me',
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: successResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/me'),
      ));

      // Act
      final result = await datasource.getMe(token);

      // Assert
      expect(result, isA<UserModel>());
      expect(result.id, equals(successResponse['id']));
      expect(result.name, equals(successResponse['name']));
      expect(result.email, equals(successResponse['email']));
      expect(result.role, equals(successResponse['role']));

      verify(mockDio.get(
        '/auth/me',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw error message on DioException', () async {
      // Arrange
      const errorMessage = 'Invalid token';
      when(mockDio.get(
        '/auth/me',
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/me'),
        message: errorMessage,
      ));

      // Act & Assert
      expect(
        () => datasource.getMe(token),
        throwsA('Failed to get user data: $errorMessage'),
      );
      verify(mockDio.get(
        '/auth/me',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw unexpected error message on non-DioException', () async {
      // Arrange
      when(mockDio.get(
        '/auth/me',
        options: anyNamed('options'),
      )).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => datasource.getMe(token),
        throwsA('An unexpected error occurred'),
      );
      verify(mockDio.get(
        '/auth/me',
        options: argThat(
          predicate((Options options) =>
              options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });
  });
}
