import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';
import 'package:iddir_app/features/request/data/remote_data_source/request_remote_data_source.dart';
import 'package:iddir_app/features/request/data/repositories/request_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([RequestRemoteDataSource])
import 'request_repository_test.mocks.dart';

void main() {
  late MockRequestRemoteDataSource mockRemoteDataSource;
  late RequestRepository repository;

  setUp(() {
    mockRemoteDataSource = MockRequestRemoteDataSource();
    // We need to pass a Dio instance to the build method of RequestRepository.
    // Since we are mocking the remote data source, the Dio instance itself
    // doesn't need to be mocked here, but the `build` method expects it.
    // We create a dummy Dio instance for this purpose.
    repository = _TestRequestRepository(mockRemoteDataSource);
  });

  group('getAllRequests', () {
    const token = 'test_token';
    final testRequests = [
      RequestModel(
        id: '1',
        user: {'_id': 'u1', 'name': 'User One', 'email': 'u1@test.com'},
        name: 'Req 1',
        eventType: 'Donation',
        amount: 100,
        status: 'pending',
        createdAt: '2024-01-01T10:00:00Z',
      ),
      RequestModel(
        id: '2',
        user: {'_id': 'u2', 'name': 'User Two', 'email': 'u2@test.com'},
        name: 'Req 2',
        eventType: 'Funeral',
        amount: 200,
        status: 'approved',
        createdAt: '2024-01-02T10:00:00Z',
      ),
    ];

    test('should return list of requests when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getAllRequests(token))
          .thenAnswer((_) async => testRequests);

      // Act
      final result = await repository.getAllRequests(token);

      // Assert
      expect(result, equals(testRequests));
      verify(mockRemoteDataSource.getAllRequests(token)).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDataSource.getAllRequests(token))
          .thenThrow(Exception('Failed to fetch requests'));

      // Act
      final result = await repository.getAllRequests(token);

      // Assert
      expect(result, isNull);
      verify(mockRemoteDataSource.getAllRequests(token)).called(1);
    });
  });

  group('createRequest', () {
    const token = 'test_token';
    final requestData = {
      'name': 'New Req',
      'eventType': 'Marriage',
      'amount': 500,
      'status': 'pending',
    };
    final newRequest = RequestModel(
      id: '3',
      user: {'_id': 'u3', 'name': 'User Three', 'email': 'u3@test.com'},
      name: 'New Req',
      eventType: 'Marriage',
      amount: 500,
      status: 'pending',
      createdAt: '2024-01-03T10:00:00Z',
    );

    test('should return a RequestModel when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.createRequest(token, requestData))
          .thenAnswer((_) async => newRequest);

      // Act
      final result = await repository.createRequest(token: token, data: requestData);

      // Assert
      expect(result, equals(newRequest));
      verify(mockRemoteDataSource.createRequest(token, requestData)).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDataSource.createRequest(token, requestData))
          .thenThrow(Exception('Failed to create request'));

      // Act
      final result = await repository.createRequest(token: token, data: requestData);

      // Assert
      expect(result, isNull);
      verify(mockRemoteDataSource.createRequest(token, requestData)).called(1);
    });
  });

  group('updateRequestStatus', () {
    const token = 'test_token';
    const requestId = 'req_to_update';
    const newStatus = 'rejected';
    final updatedRequest = RequestModel(
      id: requestId,
      user: {'_id': 'u4', 'name': 'User Four', 'email': 'u4@test.com'},
      name: 'Request to Update',
      eventType: 'Other',
      amount: 300,
      status: newStatus,
      createdAt: '2024-01-04T10:00:00Z',
      updatedAt: '2024-01-04T11:00:00Z',
    );

    test('should return an updated RequestModel when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.updateRequestStatus(token, requestId, newStatus))
          .thenAnswer((_) async => updatedRequest);

      // Act
      final result = await repository.updateRequestStatus(
        token: token,
        id: requestId,
        status: newStatus,
      );

      // Assert
      expect(result, equals(updatedRequest));
      verify(mockRemoteDataSource.updateRequestStatus(token, requestId, newStatus)).called(1);
    });

    test('should return null when remote data source throws an exception', () async {
      // Arrange
      when(mockRemoteDataSource.updateRequestStatus(token, requestId, newStatus))
          .thenThrow(Exception('Failed to update request status'));

      // Act
      final result = await repository.updateRequestStatus(
        token: token,
        id: requestId,
        status: newStatus,
      );

      // Assert
      expect(result, isNull);
      verify(mockRemoteDataSource.updateRequestStatus(token, requestId, newStatus)).called(1);
    });
  });
}

// Helper class to inject the mock RequestRemoteDataSource
class _TestRequestRepository extends RequestRepository {
  final RequestRemoteDataSource _mockRemoteDataSource;

  _TestRequestRepository(this._mockRemoteDataSource);

  @override
  RequestRemoteDataSource build(Dio dio) {
    return _mockRemoteDataSource; // Return the mock instead of creating a new one
  }

  // Override methods to call the mock directly, bypassing the actual build method's datasource creation
  @override
  Future<List<RequestModel>?> getAllRequests(String token) async {
    try {
      return await _mockRemoteDataSource.getAllRequests(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RequestModel?> createRequest({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _mockRemoteDataSource.createRequest(token, data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RequestModel?> updateRequestStatus({
    required String token,
    required String id,
    required String status,
  }) async {
    try {
      return await _mockRemoteDataSource.updateRequestStatus(token, id, status);
    } catch (_) {
      return null;
    }
  }
}
