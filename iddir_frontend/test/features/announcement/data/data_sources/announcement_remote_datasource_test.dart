import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/announcement/data/data_sources/announcement_remote_datasource.dart';
import 'package:iddir_app/features/announcement/data/models/announcement_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Dio])
import 'announcement_remote_datasource_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late AnnouncementRemoteDatasource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = AnnouncementRemoteDatasource(mockDio);
  });

  group('getAllAnnouncements', () {
    final testAnnouncements = [
      {
        '_id': '1',
        'title': 'Test Announcement 1',
        'description': 'Test Description 1',
        'date': '2024-03-20T10:00:00Z',
        'location': 'Test Location 1',
        'image': '/images/test1.jpg',
        'postedBy': {
          '_id': '123',
          'name': 'Test User',
        },
        'createdAt': '2024-03-19T10:00:00Z',
        'updatedAt': '2024-03-19T10:00:00Z',
      },
      {
        '_id': '2',
        'title': 'Test Announcement 2',
        'description': 'Test Description 2',
        'date': '2024-03-21T10:00:00Z',
        'location': 'Test Location 2',
        'image': '/images/test2.jpg',
        'postedBy': {
          '_id': '123',
          'name': 'Test User',
        },
        'createdAt': '2024-03-19T10:00:00Z',
        'updatedAt': '2024-03-19T10:00:00Z',
      },
    ];

    test('should return list of announcements when API call is successful', () async {
      when(mockDio.get('/announcements')).thenAnswer(
        (_) async => Response(
          data: testAnnouncements,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/announcements'),
        ),
      );

      final result = await dataSource.getAllAnnouncements();

      expect(result, isA<List<AnnouncementModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('2'));
      verify(mockDio.get('/announcements')).called(1);
    });

    test('should throw error when API call fails with DioException', () async {
      when(mockDio.get('/announcements')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/announcements'),
          response: Response(
            statusCode: 500,
            data: {'message': 'Server error'},
            requestOptions: RequestOptions(path: '/announcements'),
          ),
        ),
      );

      expect(
        () => dataSource.getAllAnnouncements(),
        throwsA(equals('Failed to get announcements: null')),
      );
    });

    test('should throw error when unexpected error occurs', () async {
      when(mockDio.get('/announcements')).thenThrow(Exception('Unexpected error'));

      expect(
        () => dataSource.getAllAnnouncements(),
        throwsA(equals('An unexpected error occurred')),
      );
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

    final testResponse = {
      '_id': '3',
      'title': 'New Announcement',
      'description': 'New Description',
      'date': '2024-03-20T10:00:00Z',
      'location': 'New Location',
      'image': '/images/new.jpg',
      'postedBy': {
        '_id': '123',
        'name': 'Test User',
      },
      'createdAt': '2024-03-19T10:00:00Z',
      'updatedAt': '2024-03-19T10:00:00Z',
    };

    test('should create announcement successfully with image', () async {
      when(mockDio.post(
        '/announcements',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/announcements'),
        ),
      );

      final result = await dataSource.createAnnouncement(testToken, testData, testImageData);

      expect(result, isA<AnnouncementModel>());
      expect(result.id, equals('3'));
      expect(result.title, equals('New Announcement'));
      verify(mockDio.post(
        '/announcements',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).called(1);
    });

    test('should create announcement successfully without image', () async {
      when(mockDio.post(
        '/announcements',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/announcements'),
        ),
      );

      final result = await dataSource.createAnnouncement(testToken, testData, null);

      expect(result, isA<AnnouncementModel>());
      expect(result.id, equals('3'));
      verify(mockDio.post(
        '/announcements',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when creation fails', () async {
      when(mockDio.post(
        '/announcements',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/announcements'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Invalid data'},
            requestOptions: RequestOptions(path: '/announcements'),
          ),
        ),
      );

      expect(
        () => dataSource.createAnnouncement(testToken, testData, testImageData),
        throwsA(equals('Failed to create announcement: null')),
      );
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

    final testResponse = {
      '_id': '1',
      'title': 'Updated Announcement',
      'description': 'Updated Description',
      'date': '2024-03-20T10:00:00Z',
      'location': 'Test Location',
      'image': '/images/updated.jpg',
      'postedBy': {
        '_id': '123',
        'name': 'Test User',
      },
      'createdAt': '2024-03-19T10:00:00Z',
      'updatedAt': '2024-03-19T10:00:00Z',
    };

    test('should update announcement successfully with image', () async {
      when(mockDio.put(
        '/announcements/$testId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/announcements/$testId'),
        ),
      );

      final result = await dataSource.updateAnnouncement(testToken, testId, testData, testImageData);

      expect(result, isA<AnnouncementModel>());
      expect(result.id, equals('1'));
      expect(result.title, equals('Updated Announcement'));
      verify(mockDio.put(
        '/announcements/$testId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).called(1);
    });

    test('should update announcement successfully without image', () async {
      when(mockDio.put(
        '/announcements/$testId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/announcements/$testId'),
        ),
      );

      final result = await dataSource.updateAnnouncement(testToken, testId, testData, null);

      expect(result, isA<AnnouncementModel>());
      expect(result.id, equals('1'));
      verify(mockDio.put(
        '/announcements/$testId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when update fails', () async {
      when(mockDio.put(
        '/announcements/$testId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/announcements/$testId'),
          response: Response(
            statusCode: 404,
            data: {'message': 'Announcement not found'},
            requestOptions: RequestOptions(path: '/announcements/$testId'),
          ),
        ),
      );

      expect(
        () => dataSource.updateAnnouncement(testToken, testId, testData, testImageData),
        throwsA(equals('Failed to update announcement: null')),
      );
    });
  });

  group('deleteAnnouncement', () {
    final testToken = 'test_token';
    final testId = '1';

    test('should delete announcement successfully', () async {
      when(mockDio.delete(
        '/announcements/$testId',
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: '/announcements/$testId'),
        ),
      );

      final result = await dataSource.deleteAnnouncement(testToken, testId);

      expect(result, isTrue);
      verify(mockDio.delete(
        '/announcements/$testId',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when deletion fails', () async {
      when(mockDio.delete(
        '/announcements/$testId',
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/announcements/$testId'),
          response: Response(
            statusCode: 404,
            data: {'message': 'Announcement not found'},
            requestOptions: RequestOptions(path: '/announcements/$testId'),
          ),
        ),
      );

      expect(
        () => dataSource.deleteAnnouncement(testToken, testId),
        throwsA(equals('Failed to delete announcement: null')),
      );
    });
  });
}
