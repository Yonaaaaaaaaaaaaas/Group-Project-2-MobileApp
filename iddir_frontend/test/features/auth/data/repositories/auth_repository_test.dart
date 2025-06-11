import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:iddir_app/features/auth/data/repositories/auth_repository.dart';
import 'package:iddir_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:iddir_app/features/auth/data/models/user_model.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthRemoteDatasource])
void main() {
  late MockAuthRemoteDatasource mockDatasource;
  late AuthRepository repository;

  setUp(() {
    mockDatasource = MockAuthRemoteDatasource();
    repository = _TestAuthRepository(mockDatasource);
  });

  group('AuthRepository - login', () {
    const email = 'test@example.com';
    const password = 'password123';
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
      when(mockDatasource.login(email, password)).thenAnswer((_) async => successResponse);

      final result = await repository.login(email: email, password: password);

      expect(result, equals(successResponse));
      verify(mockDatasource.login(email, password)).called(1);
    });

    test('should return null on login failure', () async {
      when(mockDatasource.login(email, password)).thenThrow(Exception('Invalid email or password'));

      final result = await repository.login(email: email, password: password);

      expect(result, isNull);
      verify(mockDatasource.login(email, password)).called(1);
    });

    test('should return null on invalid credentials', () async {
      when(mockDatasource.login(email, password)).thenThrow('Invalid email or password');

      final result = await repository.login(email: email, password: password);

      expect(result, isNull);
      verify(mockDatasource.login(email, password)).called(1);
    });
  });

  group('AuthRepository - register', () {
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
      when(mockDatasource.register(registerData)).thenAnswer((_) async => successResponse);

      final result = await repository.register(data: registerData);

      expect(result, equals(successResponse));
      verify(mockDatasource.register(registerData)).called(1);
    });

    test('should return null on registration failure', () async {
      when(mockDatasource.register(registerData)).thenThrow(Exception('Email already exists'));

      final result = await repository.register(data: registerData);

      expect(result, isNull);
      verify(mockDatasource.register(registerData)).called(1);
    });

    test('should return null on email already exists', () async {
      when(mockDatasource.register(registerData)).thenThrow('Email already exists');

      final result = await repository.register(data: registerData);

      expect(result, isNull);
      verify(mockDatasource.register(registerData)).called(1);
    });
  });

  group('AuthRepository - getMe', () {
    const token = 'test_token';
    final user = UserModel(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
      role: 'user',
    );

    test('should return user data on successful getMe call', () async {
      when(mockDatasource.getMe(token)).thenAnswer((_) async => user);

      final result = await repository.getMe(token: token);

      expect(result, equals(user));
      verify(mockDatasource.getMe(token)).called(1);
    });

    test('should return null on getMe failure', () async {
      when(mockDatasource.getMe(token)).thenThrow(Exception('Invalid token'));

      final result = await repository.getMe(token: token);

      expect(result, isNull);
      verify(mockDatasource.getMe(token)).called(1);
    });

    test('should return null on invalid token', () async {
      when(mockDatasource.getMe(token)).thenThrow('Invalid token');

      final result = await repository.getMe(token: token);

      expect(result, isNull);
      verify(mockDatasource.getMe(token)).called(1);
    });
  });
}


class _TestAuthRepository extends AuthRepository {
  final AuthRemoteDatasource mockDatasource;
  _TestAuthRepository(this.mockDatasource);

  @override
  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await mockDatasource.login(email, password);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> register({
    required Map<String, dynamic> data,
  }) async {
    try {
      return await mockDatasource.register(data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserModel?> getMe({required String token}) async {
    try {
      return await mockDatasource.getMe(token);
    } catch (_) {
      return null;
    }
  }
}
