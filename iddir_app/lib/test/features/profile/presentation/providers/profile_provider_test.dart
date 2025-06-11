import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iddir_app/features/profile/data/models/profile_model.dart';
import 'package:iddir_app/features/profile/data/repositories/profile_repository.dart';
import 'package:iddir_app/features/profile/presentation/providers/profile_provider.dart';

@GenerateMocks([ProfileRepository, SharedPreferences])
import 'profile_provider_test.mocks.dart';

void main() {
  late MockProfileRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late ProfileNotifier notifier;

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

  setUp(() {
    mockRepo = MockProfileRepository();
    mockPrefs = MockSharedPreferences();
    notifier = ProfileNotifier(mockRepo, mockPrefs);

    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('ProfileNotifier', () {
    const testToken = 'test_token';

    test('should initialize with null profile', () {
      expect(notifier.state.value, isNull);
    });

    test('should initialize profile when token exists', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(
        mockRepo.getProfile(token: testToken),
      ).thenAnswer((_) async => testProfile);

      await notifier.initializeProfile();

      expect(notifier.state.value, equals(testProfile));
      verify(mockRepo.getProfile(token: testToken)).called(1);
    });

    test('should initialize with null when token does not exist', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      await notifier.initializeProfile();

      expect(notifier.state.value, isNull);
      verifyNever(mockRepo.getProfile(token: anyNamed('token')));
    });

    test('should update state with profile on successful getProfile', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(
        mockRepo.getProfile(token: testToken),
      ).thenAnswer((_) async => testProfile);

      await notifier.getProfile();

      expect(notifier.state.value, equals(testProfile));
      verify(mockRepo.getProfile(token: testToken)).called(1);
    });

    test('should update state with error on getProfile failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getProfile(token: testToken)).thenAnswer((_) async => null);

      await notifier.getProfile();

      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.getProfile(token: testToken)).called(1);
    });

    test('should update profile successfully', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final updatedProfile = testProfile.copyWith(
        name: 'Updated Name',
        address: 'Updated Address',
        phone: '9876543210',
      );

      final testData = {
        'name': 'Updated Name',
        'address': 'Updated Address',
        'phone': '9876543210',
      };

      when(
        mockRepo.updateProfile(token: testToken, data: testData),
      ).thenAnswer((_) async => updatedProfile);

      await notifier.updateProfile(testData);

      expect(notifier.state.value, equals(updatedProfile));
      verify(
        mockRepo.updateProfile(token: testToken, data: testData),
      ).called(1);
    });

    test('should handle update profile failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final testData = {'name': 'Updated Name', 'address': 'Updated Address'};

      when(
        mockRepo.updateProfile(token: testToken, data: testData),
      ).thenAnswer((_) async => null);

      await notifier.updateProfile(testData);

      expect(notifier.state.hasError, isTrue);
      verify(
        mockRepo.updateProfile(token: testToken, data: testData),
      ).called(1);
    });

    test('should handle not logged in during update', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      final testData = {'name': 'Updated Name', 'address': 'Updated Address'};

      await notifier.updateProfile(testData);

      expect(notifier.state.hasError, isTrue);
      verifyNever(
        mockRepo.updateProfile(
          token: anyNamed('token'),
          data: anyNamed('data'),
        ),
      );
    });

    test('should update profile picture successfully', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final testImageData = FormData.fromMap({
        'image': MultipartFile.fromString('test image data'),
      });

      const newPicturePath = '/images/new-profile.jpg';

      // Set initial profile state before calling the update
      notifier.state = AsyncValue.data(testProfile);

      when(
        mockRepo.updateProfilePicture(
          token: testToken,
          imageData: testImageData,
        ),
      ).thenAnswer((_) async => newPicturePath);

      await notifier.updateProfilePicture(testImageData);

      expect(newPicturePath, equals('/images/new-profile.jpg'));

      verify(
        mockRepo.updateProfilePicture(
          token: testToken,
          imageData: testImageData,
        ),
      ).called(1);
    });

    test('should handle profile picture update failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final testImageData = FormData.fromMap({
        'image': MultipartFile.fromString('test image data'),
      });

      when(
        mockRepo.updateProfilePicture(
          token: testToken,
          imageData: testImageData,
        ),
      ).thenAnswer((_) async => null);

      await notifier.updateProfilePicture(testImageData);

      expect(notifier.state.hasError, isTrue);
      verify(
        mockRepo.updateProfilePicture(
          token: testToken,
          imageData: testImageData,
        ),
      ).called(1);
    });

    test('should handle not logged in during picture update', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      final testImageData = FormData.fromMap({
        'image': MultipartFile.fromString('test image data'),
      });

      await notifier.updateProfilePicture(testImageData);

      expect(notifier.state.hasError, isTrue);
      verifyNever(
        mockRepo.updateProfilePicture(
          token: anyNamed('token'),
          imageData: anyNamed('imageData'),
        ),
      );
    });

    test('should delete account successfully', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(
        mockRepo.deleteAccount(token: testToken),
      ).thenAnswer((_) async => true);

      final result = await notifier.deleteAccount();

      expect(result, isTrue);
      expect(notifier.state.value, isNull);
      verify(mockRepo.deleteAccount(token: testToken)).called(1);
      verify(mockPrefs.remove(any)).called(1);
    });

    test('should handle account deletion failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(
        mockRepo.deleteAccount(token: testToken),
      ).thenAnswer((_) async => false);

      final result = await notifier.deleteAccount();

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.deleteAccount(token: testToken)).called(1);
      verifyNever(mockPrefs.remove(any));
    });

    test('should handle not logged in during account deletion', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      final result = await notifier.deleteAccount();

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verifyNever(mockRepo.deleteAccount(token: anyNamed('token')));
      verifyNever(mockPrefs.remove(any));
    });
  });
}
