import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/request/data/remote_data_source/request_remote_data_source.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'request_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio, BaseOptions])
void main() {
  late RequestRemoteDataSource dataSource;
  late MockDio mockDio;
  late MockBaseOptions mockBaseOptions;

  setUp(() {
    mockDio = MockDio();
    mockBaseOptions = MockBaseOptions();
    when(mockDio.options).thenReturn(mockBaseOptions);
    when(mockBaseOptions.baseUrl).thenReturn('http://localhost:5000'); // Mock base URL
    dataSource = RequestRemoteDataSource(mockDio);
  });

  group('getAllRequests', () {
    const token = 'test_token';
    final testRequests = [
      {
        '_id': '1',
        'user': {'_id': 'u1', 'name': 'User One', 'email': 'u1@test.com'},
        'name': 'Request One',
        'eventType': 'Donation',
        'amount': 100,
        'status': 'pending',
        'createdAt': '2024-01-01T10:00:00Z',
        'updatedAt': '2024-01-01T10:00:00Z',
      },
      {
        '_id': '2',
        'user': {'_id': 'u2', 'name': 'User Two', 'email': 'u2@test.com'},
        'name': 'Request Two',
        'eventType': 'Funeral',
        'amount': 200,
        'status': 'approved',
        'createdAt': '2024-01-02T10:00:00Z',
        'updatedAt': '2024-01-02T10:00:00Z',
      },
    ];

    test('should return a list of RequestModel when API call is successful', () async {
      // Arrange
      when(mockDio.get(
        '/requests',
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: testRequests,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/requests'),
      ));

      // Act
      final result = await dataSource.getAllRequests(token);

      // Assert
      expect(result, isA<List<RequestModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].name, equals('Request Two'));
      verify(mockDio.get(
        '/requests',
        options: argThat(
          predicate((Options options) => options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw an Exception when API call fails with DioException', () async {
      // Arrange
      when(mockDio.get(
        '/requests',
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/requests'),
        error: 'Network error',
      ));

      // Act & Assert
      expect(
        () => dataSource.getAllRequests(token),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.get(
        '/requests',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw an Exception when an unexpected error occurs', () async {
      // Arrange
      when(mockDio.get(
        '/requests',
        options: anyNamed('options'),
      )).thenThrow(Exception('Something went wrong'));

      // Act & Assert
      expect(
        () => dataSource.getAllRequests(token),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.get(
        '/requests',
        options: anyNamed('options'),
      )).called(1);
    });
  });

  group('createRequest', () {
    const token = 'test_token';
    final requestData = {
      'name': 'New Request',
      'eventType': 'Marriage',
      'amount': 500,
      'status': 'pending',
    };
    final newRequestResponse = {
      '_id': '3',
      'user': {'_id': 'u3', 'name': 'User Three', 'email': 'u3@test.com'},
      'name': 'New Request',
      'eventType': 'Marriage',
      'amount': 500,
      'status': 'pending',
      'createdAt': '2024-01-03T10:00:00Z',
      'updatedAt': '2024-01-03T10:00:00Z',
    };

    test('should return a RequestModel when API call is successful', () async {
      // Arrange
      when(mockDio.post(
        '/requests',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: newRequestResponse,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/requests'),
      ));

      // Act
      final result = await dataSource.createRequest(token, requestData);

      // Assert
      expect(result, isA<RequestModel>());
      expect(result.id, equals('3'));
      expect(result.name, equals('New Request'));
      verify(mockDio.post(
        '/requests',
        data: requestData,
        options: argThat(
          predicate((Options options) => options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw an Exception when API call fails with DioException', () async {
      // Arrange
      when(mockDio.post(
        '/requests',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/requests'),
        error: 'Validation error',
      ));

      // Act & Assert
      expect(
        () => dataSource.createRequest(token, requestData),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.post(
        '/requests',
        data: requestData,
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw an Exception when an unexpected error occurs', () async {
      // Arrange
      when(mockDio.post(
        '/requests',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(Exception('Server down'));

      // Act & Assert
      expect(
        () => dataSource.createRequest(token, requestData),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.post(
        '/requests',
        data: requestData,
        options: anyNamed('options'),
      )).called(1);
    });
  });

  group('updateRequestStatus', () {
    const token = 'test_token';
    const requestId = 'req_to_update';
    const newStatus = 'rejected';
    final updatedRequestResponse = {
      '_id': requestId,
      'user': {'_id': 'u4', 'name': 'User Four', 'email': 'u4@test.com'},
      'name': 'Request to Update',
      'eventType': 'Other',
      'amount': 300,
      'status': newStatus,
      'createdAt': '2024-01-04T10:00:00Z',
      'updatedAt': '2024-01-04T11:00:00Z',
    };

    test('should return an updated RequestModel when API call is successful', () async {
      // Arrange
      when(mockDio.put(
        '/requests/$requestId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
        data: updatedRequestResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/requests/$requestId'),
      ));

      // Act
      final result = await dataSource.updateRequestStatus(token, requestId, newStatus);

      // Assert
      expect(result, isA<RequestModel>());
      expect(result.id, equals(requestId));
      expect(result.status, equals(newStatus));
      verify(mockDio.put(
        '/requests/$requestId',
        data: {'status': newStatus},
        options: argThat(
          predicate((Options options) => options.headers?['Authorization'] == 'Bearer $token'),
          named: 'options',
        ),
      )).called(1);
    });

    test('should throw an Exception when API call fails with DioException', () async {
      // Arrange
      when(mockDio.put(
        '/requests/$requestId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/requests/$requestId'),
        error: 'Request not found',
      ));

      // Act & Assert
      expect(
        () => dataSource.updateRequestStatus(token, requestId, newStatus),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.put(
        '/requests/$requestId',
        data: {'status': newStatus},
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw an Exception when an unexpected error occurs', () async {
      // Arrange
      when(mockDio.put(
        '/requests/$requestId',
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(Exception('Database error'));

      // Act & Assert
      expect(
        () => dataSource.updateRequestStatus(token, requestId, newStatus),
        throwsA(isA<Exception>()),
      );
      verify(mockDio.put(
        '/requests/$requestId',
        data: {'status': newStatus},
        options: anyNamed('options'),
      )).called(1);
    });
  });
}
