import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iddir_app/features/announcement/data/models/announcement_model.dart';
import 'package:iddir_app/features/announcement/data/repositories/announcement_repository.dart';
import 'package:iddir_app/features/announcement/presentation/providers/announcement_provider.dart';

@GenerateMocks([AnnouncementRepository, SharedPreferences])
import 'announcement_provider_test.mocks.dart';

void main() {
  late MockAnnouncementRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late AnnouncementNotifier notifier;

  final testAnnouncements = [
    AnnouncementModel(
      id: '1',
      title: 'Test Announcement 1',
      description: 'Test Description 1',
      date: DateTime.parse('2024-03-20T10:00:00Z'),
      location: 'Test Location 1',
      image: '/images/test1.jpg',
      postedBy: PostedByModel(id: '123', name: 'Test User'),
      createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      updatedAt: DateTime.parse('2024-03-19T10:00:00Z'),
    ),
    AnnouncementModel(
      id: '2',
      title: 'Test Announcement 2',
      description: 'Test Description 2',
      date: DateTime.parse('2024-03-21T10:00:00Z'),
      location: 'Test Location 2',
      image: '/images/test2.jpg',
      postedBy: PostedByModel(id: '123', name: 'Test User'),
      createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      updatedAt: DateTime.parse('2024-03-19T10:00:00Z'),
    ),
  ];

  setUp(() {
    mockRepo = MockAnnouncementRepository();
    mockPrefs = MockSharedPreferences();
    notifier = AnnouncementNotifier(mockRepo, mockPrefs);

    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('AnnouncementNotifier', () {
    const testToken = 'test_token';

    test('should initialize with empty list', () {
      expect(notifier.state.value, isEmpty);
    });

    test('should update state with announcements on successful getAllAnnouncements', () async {
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      expect(notifier.state.value, equals(testAnnouncements));
      verify(mockRepo.getAllAnnouncements()).called(1);
    });

    test('should update state with error on getAllAnnouncements failure', () async {
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => null);

      await notifier.getAllAnnouncements();

      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.getAllAnnouncements()).called(1);
    });

    test('should add new announcement on successful create', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final newAnnouncement = AnnouncementModel(
        id: '3',
        title: 'New Announcement',
        description: 'New Description',
        date: DateTime.parse('2024-03-20T10:00:00Z'),
        location: 'New Location',
        image: '/images/new.jpg',
        postedBy: PostedByModel(id: '123', name: 'Test User'),
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
        updatedAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      final testData = {
        'title': 'New Announcement',
        'description': 'New Description',
        'date': '2024-03-20T10:00:00Z',
        'location': 'New Location',
      };

      when(mockRepo.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: null,
      )).thenAnswer((_) async => newAnnouncement);

      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => [newAnnouncement]);

      final result = await notifier.createAnnouncement(testData, null);
      await notifier.getAllAnnouncements();

      expect(result, isTrue);
      expect(notifier.state.value, contains(newAnnouncement));
      verify(mockRepo.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: null,
      )).called(1);
    });

    test('should return false on create failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);

      final testData = {
        'title': 'New Announcement',
        'description': 'New Description',
      };

      when(mockRepo.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: null,
      )).thenAnswer((_) async => null);

      final result = await notifier.createAnnouncement(testData, null);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: null,
      )).called(1);
    });

    test('should return false when not logged in during create', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      final testData = {
        'title': 'New Announcement',
        'description': 'New Description',
      };

      final result = await notifier.createAnnouncement(testData, null);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verifyNever(mockRepo.createAnnouncement(
        token: anyNamed('token'),
        data: anyNamed('data'),
        imageData: anyNamed('imageData'),
      ));
    });

    test('should update announcement on successful update', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';
      final testData = {
        'title': 'Updated Announcement',
        'description': 'Updated Description',
      };

      final updatedAnnouncement = AnnouncementModel(
        id: '1',
        title: 'Updated Announcement',
        description: 'Updated Description',
        date: DateTime.parse('2024-03-20T10:00:00Z'),
        location: 'Test Location 1',
        image: '/images/test1.jpg',
        postedBy: PostedByModel(id: '123', name: 'Test User'),
        createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
        updatedAt: DateTime.parse('2024-03-19T10:00:00Z'),
      );

      when(mockRepo.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: null,
      )).thenAnswer((_) async => updatedAnnouncement);

      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => [updatedAnnouncement, testAnnouncements[1]]);

      final result = await notifier.updateAnnouncement(testId, testData, null);
      await notifier.getAllAnnouncements();

      expect(result, isTrue);
      expect(notifier.state.value?.firstWhere((a) => a.id == testId),
          equals(updatedAnnouncement));
      verify(mockRepo.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: null,
      )).called(1);
    });

    test('should return false on update failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';
      final testData = {
        'title': 'Updated Announcement',
        'description': 'Updated Description',
      };

      when(mockRepo.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: null,
      )).thenAnswer((_) async => null);

      final result = await notifier.updateAnnouncement(testId, testData, null);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: null,
      )).called(1);
    });

    test('should return false when not logged in during update', () async {
      when(mockPrefs.getString(any)).thenReturn(null);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';
      final testData = {
        'title': 'Updated Announcement',
        'description': 'Updated Description',
      };

      final result = await notifier.updateAnnouncement(testId, testData, null);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verifyNever(mockRepo.updateAnnouncement(
        token: anyNamed('token'),
        id: anyNamed('id'),
        data: anyNamed('data'),
        imageData: anyNamed('imageData'),
      ));
    });

    test('should remove announcement on successful delete', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';

      when(mockRepo.deleteAnnouncement(
        token: testToken,
        id: testId,
      )).thenAnswer((_) async => true);

      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => [testAnnouncements[1]]);

      final result = await notifier.deleteAnnouncement(testId);
      await notifier.getAllAnnouncements();

      expect(result, isTrue);
      expect(notifier.state.value?.length, equals(1));
      expect(notifier.state.value?.any((a) => a.id == testId), isFalse);
      verify(mockRepo.deleteAnnouncement(
        token: testToken,
        id: testId,
      )).called(1);
    });

    test('should return false on delete failure', () async {
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';

      when(mockRepo.deleteAnnouncement(
        token: testToken,
        id: testId,
      )).thenAnswer((_) async => false);

      final result = await notifier.deleteAnnouncement(testId);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verify(mockRepo.deleteAnnouncement(
        token: testToken,
        id: testId,
      )).called(1);
    });

    test('should return false when not logged in during delete', () async {
      when(mockPrefs.getString(any)).thenReturn(null);
      when(mockRepo.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      await notifier.getAllAnnouncements();

      const testId = '1';

      final result = await notifier.deleteAnnouncement(testId);

      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      verifyNever(mockRepo.deleteAnnouncement(
        token: anyNamed('token'),
        id: anyNamed('id'),
      ));
    });
  });
}
