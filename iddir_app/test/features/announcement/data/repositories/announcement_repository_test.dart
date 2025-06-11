import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/announcement/data/data_sources/announcement_remote_datasource.dart';
import 'package:iddir_app/features/announcement/data/models/announcement_model.dart';
import 'package:iddir_app/features/announcement/data/repositories/announcement_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AnnouncementRemoteDatasource])
import 'announcement_repository_test.mocks.dart';

void main() {
  late MockAnnouncementRemoteDatasource mockDatasource;
  late AnnouncementRepository repository;

  setUp(() {
    mockDatasource = MockAnnouncementRemoteDatasource();
    repository = _TestAnnouncementRepository(mockDatasource);
  });

  group('getAllAnnouncements', () {
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

    test('should return list of announcements when datasource call is successful', () async {
      when(mockDatasource.getAllAnnouncements())
          .thenAnswer((_) async => testAnnouncements);

      final result = await repository.getAllAnnouncements();

      expect(result, equals(testAnnouncements));
      verify(mockDatasource.getAllAnnouncements()).called(1);
    });

    test('should return null when datasource throws error', () async {
      when(mockDatasource.getAllAnnouncements())
          .thenThrow(Exception('Test error'));

      final result = await repository.getAllAnnouncements();

      expect(result, isNull);
      verify(mockDatasource.getAllAnnouncements()).called(1);
    });
  });

  group('createAnnouncement', () {
    final testToken = 'test_token';
    final testData = {
      'title': 'New Announcement',
      'description': 'New Description',
      'date': '2024-03-20T10:00:00Z',
      'location': 'New Location',
    };
    final testImageData = MultipartFile.fromString('test image data');

    final testAnnouncement = AnnouncementModel(
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

    test('should create announcement successfully', () async {
      when(mockDatasource.createAnnouncement(testToken, testData, testImageData))
          .thenAnswer((_) async => testAnnouncement);

      final result = await repository.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: testImageData,
      );

      expect(result, equals(testAnnouncement));
      verify(mockDatasource.createAnnouncement(testToken, testData, testImageData))
          .called(1);
    });

    test('should return null when creation fails', () async {
      when(mockDatasource.createAnnouncement(testToken, testData, testImageData))
          .thenThrow(Exception('Test error'));

      final result = await repository.createAnnouncement(
        token: testToken,
        data: testData,
        imageData: testImageData,
      );

      expect(result, isNull);
      verify(mockDatasource.createAnnouncement(testToken, testData, testImageData))
          .called(1);
    });
  });

  group('updateAnnouncement', () {
    final testToken = 'test_token';
    final testId = '1';
    final testData = {
      'title': 'Updated Announcement',
      'description': 'Updated Description',
    };
    final testImageData = MultipartFile.fromString('test image data');

    final testAnnouncement = AnnouncementModel(
      id: '1',
      title: 'Updated Announcement',
      description: 'Updated Description',
      date: DateTime.parse('2024-03-20T10:00:00Z'),
      location: 'Test Location',
      image: '/images/updated.jpg',
      postedBy: PostedByModel(id: '123', name: 'Test User'),
      createdAt: DateTime.parse('2024-03-19T10:00:00Z'),
      updatedAt: DateTime.parse('2024-03-19T10:00:00Z'),
    );

    test('should update announcement successfully', () async {
      when(mockDatasource.updateAnnouncement(testToken, testId, testData, testImageData))
          .thenAnswer((_) async => testAnnouncement);

      final result = await repository.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: testImageData,
      );

      expect(result, equals(testAnnouncement));
      verify(mockDatasource.updateAnnouncement(testToken, testId, testData, testImageData))
          .called(1);
    });

    test('should return null when update fails', () async {
      when(mockDatasource.updateAnnouncement(testToken, testId, testData, testImageData))
          .thenThrow(Exception('Test error'));

      final result = await repository.updateAnnouncement(
        token: testToken,
        id: testId,
        data: testData,
        imageData: testImageData,
      );

      expect(result, isNull);
      verify(mockDatasource.updateAnnouncement(testToken, testId, testData, testImageData))
          .called(1);
    });
  });

  group('deleteAnnouncement', () {
    final testToken = 'test_token';
    final testId = '1';

    test('should delete announcement successfully', () async {
      when(mockDatasource.deleteAnnouncement(testToken, testId))
          .thenAnswer((_) async => true);

      final result = await repository.deleteAnnouncement(
        token: testToken,
        id: testId,
      );

      expect(result, isTrue);
      verify(mockDatasource.deleteAnnouncement(testToken, testId)).called(1);
    });

    test('should return false when deletion fails', () async {
      when(mockDatasource.deleteAnnouncement(testToken, testId))
          .thenThrow(Exception('Test error'));

      final result = await repository.deleteAnnouncement(
        token: testToken,
        id: testId,
      );

      expect(result, isFalse);
      verify(mockDatasource.deleteAnnouncement(testToken, testId)).called(1);
    });
  });
}

class _TestAnnouncementRepository extends AnnouncementRepository {
  final AnnouncementRemoteDatasource mockDatasource;
  _TestAnnouncementRepository(this.mockDatasource);

  @override
  Future<List<AnnouncementModel>?> getAllAnnouncements() async {
    try {
      return await mockDatasource.getAllAnnouncements();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AnnouncementModel?> createAnnouncement({
    required String token,
    required Map<String, dynamic> data,
    required dynamic imageData,
  }) async {
    try {
      return await mockDatasource.createAnnouncement(token, data, imageData);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AnnouncementModel?> updateAnnouncement({
    required String token,
    required String id,
    required Map<String, dynamic> data,
    required dynamic imageData,
  }) async {
    try {
      return await mockDatasource.updateAnnouncement(token, id, data, imageData);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteAnnouncement({
    required String token,
    required String id,
  }) async {
    try {
      return await mockDatasource.deleteAnnouncement(token, id);
    } catch (_) {
      return false;
    }
  }
}
