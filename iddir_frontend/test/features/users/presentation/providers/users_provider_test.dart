import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iddir_app/features/users/data/models/users_model.dart';
import 'package:iddir_app/features/users/data/repositories/users_repository.dart';
import 'package:iddir_app/features/users/presentation/providers/users_provider.dart';

@GenerateMocks([UsersRepository, SharedPreferences])
import 'users_provider_test.mocks.dart';

void main() {
  late MockUsersRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late UsersNotifier notifier;
  late SingleUserNotifier singleUserNotifier;

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

  setUp(() {
    mockRepo = MockUsersRepository();
    mockPrefs = MockSharedPreferences();
    notifier = UsersNotifier(mockRepo, mockPrefs);
    singleUserNotifier = SingleUserNotifier(mockRepo, mockPrefs, '1');

    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('UsersNotifier', () {
    const testToken = 'test_token';

    test('should initialize with null users', () {
      expect(notifier.state.value, isNull);
    });

    test('should initialize users when token exists', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllUsers(token: testToken))
          .thenAnswer((_) async => testUsers);

      await notifier.initializeUsers();

      expect(notifier.state.value, equals(testUsers));
      verify(mockRepo.getAllUsers(token: testToken)).called(1);
    });

    test('should initialize with null when token does not exist', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      await notifier.initializeUsers();

      expect(notifier.state.value, isNull);
      verifyNever(mockRepo.getAllUsers(token: anyNamed('token')));
    });

    test('should update state with users on successful getAllUsers', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllUsers(token: testToken))
          .thenAnswer((_) async => testUsers);

      await notifier.getAllUsers();

      expect(notifier.state.value, equals(testUsers));
      verify(mockRepo.getAllUsers(token: testToken)).called(1);
    });

    test('should update state with error on getAllUsers failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllUsers(token: testToken))
          .thenAnswer((_) async => null);

      await notifier.getAllUsers();

      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.getAllUsers(token: testToken)).called(1);
    });

    test('should delete user successfully', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.deleteUser(token: testToken, userId: '1'))
          .thenAnswer((_) async => true);

      // Set initial state with users
      notifier.state = AsyncValue.data(testUsers);

      final result = await notifier.deleteUser('1');

      expect(result, isTrue);
      expect(notifier.state.value?.length, equals(1));
      expect(notifier.state.value?.first.id, equals('2'));
      verify(mockRepo.deleteUser(token: testToken, userId: '1')).called(1);
    });

    test('should handle user deletion failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.deleteUser(token: testToken, userId: '1'))
          .thenAnswer((_) async => false);

      // Set initial state with users
      notifier.state = AsyncValue.data(testUsers);

      final result = await notifier.deleteUser('1');

      // The method should return false on failure
      expect(result, isFalse);
      // The state should remain unchanged since deletion failed
      expect(notifier.state.value, equals(testUsers));
      verify(mockRepo.deleteUser(token: testToken, userId: '1')).called(1);
    });

    test('should handle not logged in during user deletion', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      // Set initial state with users
      notifier.state = AsyncValue.data(testUsers);

      final result = await notifier.deleteUser('1');

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verifyNever(mockRepo.deleteUser(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
      ));
    });
  });

  group('SingleUserNotifier', () {
    const testToken = 'test_token';
    const testUserId = '1';
    final testUser = UsersModel(
      id: testUserId,
      name: 'Test User',
      email: 'test@example.com',
      address: '123 Test St',
      phone: '1234567890',
      role: 'user',
      createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
    );

    test('should initialize with null user', () {
      expect(singleUserNotifier.state.value, isNull);
    });

    test('should update state with user on successful getUser', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getUser(token: testToken, userId: testUserId))
          .thenAnswer((_) async => testUser);

      await singleUserNotifier.getUser();

      expect(singleUserNotifier.state.value, equals(testUser));
      verify(mockRepo.getUser(token: testToken, userId: testUserId)).called(1);
    });

    test('should update state with error on getUser failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getUser(token: testToken, userId: testUserId))
          .thenAnswer((_) async => null);

      await singleUserNotifier.getUser();

      expect(singleUserNotifier.state.hasError, isTrue);
      verify(mockRepo.getUser(token: testToken, userId: testUserId)).called(1);
    });

    test('should handle not logged in during getUser', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      await singleUserNotifier.getUser();

      expect(singleUserNotifier.state.value, isNull);
      verifyNever(mockRepo.getUser(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
      ));
    });
  });
}
