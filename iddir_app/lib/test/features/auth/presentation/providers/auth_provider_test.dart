import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/features/auth/data/repositories/auth_repository.dart';
import 'package:iddir_app/features/auth/data/models/user_model.dart';
import 'package:iddir_app/features/auth/presentation/providers/auth_provider.dart';

@GenerateMocks([AuthRepository, SharedPreferences])
import 'auth_provider_test.mocks.dart';

void main() {
  late MockAuthRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late AuthNotifier notifier;

  setUp(() {
    mockRepo = MockAuthRepository();
    mockPrefs = MockSharedPreferences();

    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('AuthNotifier', () {
    const token = 'test_token';
    final user = UserModel(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
      role: 'user',
    );

    test('should initialize with loading state', () async {
      // Add delay to simulate async behavior
      when(mockPrefs.getString(any)).thenReturn(token);
      when(mockRepo.getMe(token: token)).thenAnswer((_) async {
        await Future.delayed(Duration(milliseconds: 50));
        return user;
      });

      notifier = AuthNotifier(mockRepo, mockPrefs);

      // Immediately check for loading state
      expect(notifier.state.isLoading, isTrue);
    });

    test('should initialize with user data on first getMe call', () async {
      when(mockPrefs.getString(any)).thenReturn(token);
      when(mockRepo.getMe(token: token)).thenAnswer((_) async => user);

      notifier = AuthNotifier(mockRepo, mockPrefs);

      await notifier.getMe();

      expect(notifier.state.value, equals(user));
      verify(mockPrefs.getString(any)).called(greaterThanOrEqualTo(1));
      verify(mockRepo.getMe(token: token)).called(2);
    });

    test('should update state with user data on successful login', () async {
      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      const email = 'test@example.com';
      const password = 'password123';
      final loginResponse = {
        'token': token,
        'user': {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'role': user.role,
        },
      };

      when(mockRepo.login(email: email, password: password))
          .thenAnswer((_) async => loginResponse);

      await notifier.login(email, password);

      expect(notifier.state.value, equals(user));
      verify(mockRepo.login(email: email, password: password)).called(1);
      verify(mockPrefs.setString(any, any)).called(1);
    });

    test('should update state with error on login failure', () async {
      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      const email = 'test@example.com';
      const password = 'password123';

      when(mockRepo.login(email: email, password: password))
          .thenAnswer((_) async => null);

      await notifier.login(email, password);

      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.login(email: email, password: password)).called(1);
      verifyNever(mockPrefs.setString(any, any));
    });

    test('should update state with user data on successful registration', () async {
      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      final registerData = {
        'name': user.name,
        'email': user.email,
        'password': 'password123',
      };
      final registerResponse = {
        'token': token,
        'user': {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'role': user.role,
        },
      };

      when(mockRepo.register(data: registerData))
          .thenAnswer((_) async => registerResponse);

      await notifier.register(registerData);

      expect(notifier.state.value, equals(user));
      verify(mockRepo.register(data: registerData)).called(1);
      verify(mockPrefs.setString(any, any)).called(1);
    });

    test('should update state with error on registration failure', () async {
      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      final registerData = {
        'name': user.name,
        'email': user.email,
        'password': 'password123',
      };

      when(mockRepo.register(data: registerData))
          .thenAnswer((_) async => null);

      await notifier.register(registerData);

      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.register(data: registerData)).called(1);
      verifyNever(mockPrefs.setString(any, any));
    });

    test('should update state with user data on successful getMe', () async {
      when(mockPrefs.getString(any)).thenReturn(token);
      when(mockRepo.getMe(token: token)).thenAnswer((_) async => user);

      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      expect(notifier.state.value, equals(user));
      verify(mockPrefs.getString(any)).called(greaterThanOrEqualTo(1));
      verify(mockRepo.getMe(token: token)).called(2);
    });

    test('should update state with null if no token exists', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      expect(notifier.state.value, isNull);
      verify(mockPrefs.getString(any)).called(greaterThanOrEqualTo(1));
      verifyNever(mockRepo.getMe(token: anyNamed('token')));
    });

    test('should update state with error on getMe failure', () async {
      when(mockPrefs.getString(any)).thenReturn(token);
      when(mockRepo.getMe(token: token)).thenAnswer((_) async => null);

      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      expect(notifier.state.hasError, isTrue);
      verify(mockPrefs.getString(any)).called(greaterThanOrEqualTo(1));
      verify(mockRepo.getMe(token: token)).called(2);
    });

    test('logout should clear token and update state to null', () async {
      notifier = AuthNotifier(mockRepo, mockPrefs);
      await notifier.getMe();

      reset(mockPrefs);
      when(mockPrefs.remove(any)).thenAnswer((_) async => true);

      await notifier.logout();

      expect(notifier.state.value, isNull);
      verify(mockPrefs.remove(any)).called(1);
    });
  });
}
