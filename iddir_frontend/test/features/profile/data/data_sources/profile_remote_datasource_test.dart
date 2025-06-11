import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:iddir_app/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:iddir_app/features/profile/data/models/profile_model.dart';

@GenerateMocks([Dio, BaseOptions])
import 'profile_remote_datasource_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockBaseOptions mockBaseOptions;
  late ProfileRemoteDatasource dataSource;

  setUp(() {
    mockBaseOptions = MockBaseOptions();
    mockDio = MockDio();
    when(mockDio.options).thenReturn(mockBaseOptions);
    when(mockBaseOptions.baseUrl).thenReturn('http://localhost:5000');
    dataSource = ProfileRemoteDatasource(mockDio);
  });

  group('getProfile', () {
    final testToken = 'test_token';
    final testProfile = {
      '_id': '123',
      'name': 'Test User',
      'email': 'test@example.com',
      'address': '123 Test St',
      'phone': '1234567890',
      'role': 'user',
      'profilePicture': '/images/profile.jpg',
      'paymentStatus': 'pending',
      'paymentReceipt': '/receipts/test.pdf',
      'paymentApprovedAt': '2024-03-20T10:00:00Z',
    };

    test('should return profile when API call is successful', () async {
      when(mockDio.get(
        '/profile',
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testProfile,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile'),
        ),
      );

      final result = await dataSource.getProfile(testToken);

      expect(result, isA<ProfileModel>());
      expect(result.id, equals('123'));
      expect(result.name, equals('Test User'));
      expect(result.email, equals('test@example.com'));
      expect(result.address, equals('123 Test St'));
      expect(result.phone, equals('1234567890'));
      expect(result.role, equals('user'));
      expect(result.profilePicture, equals('/images/profile.jpg'));
      expect(result.paymentStatus, equals('pending'));
      expect(result.paymentReceipt, equals('/receipts/test.pdf'));
      expect(result.paymentApprovedAt, equals(DateTime.parse('2024-03-20T10:00:00Z')));

      verify(mockDio.get(
        '/profile',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when API call fails with DioException', () async {
      when(mockDio.get(
        '/profile',
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/profile'),
          response: Response(
            statusCode: 401,
            data: {'message': 'Unauthorized'},
            requestOptions: RequestOptions(path: '/profile'),
          ),
        ),
      );

      expect(
        () => dataSource.getProfile(testToken),
        throwsA(contains('Failed to get profile data')),
      );
    });

    test('should throw error when unexpected error occurs', () async {
      when(mockDio.get(
        '/profile',
        options: anyNamed('options'),
      )).thenThrow(Exception('Unexpected error'));

      expect(
        () => dataSource.getProfile(testToken),
        throwsA(equals('An unexpected error occurred')),
      );
    });
  });

  group('updateProfile', () {
    final testToken = 'test_token';
    final testData = {
      'name': 'Updated Name',
      'address': 'Updated Address',
      'phone': '9876543210',
    };

    final testResponse = {
      'user': {
        '_id': '123',
        'name': 'Updated Name',
        'email': 'test@example.com',
        'address': 'Updated Address',
        'phone': '9876543210',
        'role': 'user',
        'profilePicture': '/images/profile.jpg',
        'paymentStatus': 'pending',
        'paymentReceipt': '/receipts/test.pdf',
        'paymentApprovedAt': '2024-03-20T10:00:00Z',
      }
    };

    test('should update profile successfully', () async {
      when(mockDio.put(
        '/profile',
        data: testData,
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile'),
        ),
      );

      final result = await dataSource.updateProfile(testToken, testData);

      expect(result, isA<ProfileModel>());
      expect(result.id, equals('123'));
      expect(result.name, equals('Updated Name'));
      expect(result.address, equals('Updated Address'));
      expect(result.phone, equals('9876543210'));

      verify(mockDio.put(
        '/profile',
        data: testData,
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when update fails', () async {
      when(mockDio.put(
        '/profile',
        data: testData,
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/profile'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Invalid data'},
            requestOptions: RequestOptions(path: '/profile'),
          ),
        ),
      );

      expect(
        () => dataSource.updateProfile(testToken, testData),
        throwsA(contains('Failed to update profile')),
      );
    });
  });

  group('updateProfilePicture', () {
    final testToken = 'test_token';
    final testImageData = FormData.fromMap({
      'image': MultipartFile.fromString('test image data'),
    });

    test('should update profile picture successfully', () async {
      when(mockDio.put(
        '/profile/picture',
        data: testImageData,
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: {'profilePicture': '/images/new-profile.jpg'},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile/picture'),
        ),
      );

      final result = await dataSource.updateProfilePicture(testToken, testImageData);

      expect(result, equals('http://localhost:5000/public/images/new-profile.jpg'));
      verify(mockDio.put(
        '/profile/picture',
        data: testImageData,
        options: anyNamed('options'),
      )).called(1);
    });

    test('should handle backslashes in profile picture path', () async {
      when(mockDio.put(
        '/profile/picture',
        data: testImageData,
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: {'profilePicture': '\\images\\new-profile.jpg'},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile/picture'),
        ),
      );

      final result = await dataSource.updateProfilePicture(testToken, testImageData);

      expect(result, equals('http://localhost:5000/public/images/new-profile.jpg'));
    });

    test('should throw error when profile picture URL is missing', () async {
      when(mockDio.put(
        '/profile/picture',
        data: testImageData,
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile/picture'),
        ),
      );

      expect(
        () => dataSource.updateProfilePicture(testToken, testImageData),
        throwsA(contains('Failed to get profile picture URL')),
      );
    });

    test('should throw error when update fails', () async {
      when(mockDio.put(
        '/profile/picture',
        data: testImageData,
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/profile/picture'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Invalid image'},
            requestOptions: RequestOptions(path: '/profile/picture'),
          ),
        ),
      );

      expect(
        () => dataSource.updateProfilePicture(testToken, testImageData),
        throwsA(contains('Failed to update profile picture')),
      );
    });
  });

  group('deleteAccount', () {
    final testToken = 'test_token';

    test('should delete account successfully', () async {
      when(mockDio.delete(
        '/profile',
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: '/profile'),
        ),
      );

      final result = await dataSource.deleteAccount(testToken);

      expect(result, isTrue);
      verify(mockDio.delete(
        '/profile',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw error when deletion fails', () async {
      when(mockDio.delete(
        '/profile',
        options: anyNamed('options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/profile'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Failed to delete account'},
            requestOptions: RequestOptions(path: '/profile'),
          ),
        ),
      );

      expect(
        () => dataSource.deleteAccount(testToken),
        throwsA(contains('Failed to delete account')),
      );
    });
  });
}
