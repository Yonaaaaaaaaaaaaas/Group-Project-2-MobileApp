import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';
import 'package:iddir_app/features/request/data/repositories/request_repository.dart';
import 'package:iddir_app/features/request/presentation/providers/request_provider.dart';

@GenerateMocks([RequestRepository, SharedPreferences])
import 'request_provider_test.mocks.dart';

void main() {
  late MockRequestRepository mockRepo;
  late MockSharedPreferences mockPrefs;
  late RequestNotifier notifier;

  final testRequests = [
    RequestModel(
      id: '1',
      user: {'_id': 'u1', 'name': 'User One', 'email': 'u1@test.com'},
      name: 'Req 1',
      eventType: 'Donation',
      amount: 100,
      status: 'pending',
      createdAt: '2024-01-01T10:00:00Z',
      updatedAt: '2024-01-01T10:00:00Z',
    ),
    RequestModel(
      id: '2',
      user: {'_id': 'u2', 'name': 'User Two', 'email': 'u2@test.com'},
      name: 'Req 2',
      eventType: 'Funeral',
      amount: 200,
      status: 'approved',
      createdAt: '2024-01-02T10:00:00Z',
      updatedAt: '2024-01-02T10:00:00Z',
    ),
  ];

  setUp(() {
    mockRepo = MockRequestRepository();
    mockPrefs = MockSharedPreferences();
    notifier = RequestNotifier(mockRepo, mockPrefs);

    // Default mock behaviors
    when(mockPrefs.getString(any)).thenReturn(null); // No token by default
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.remove(any)).thenAnswer((_) async => true);
  });

  group('RequestNotifier - getAllRequests', () {
    const testToken = 'test_token';

    test('should initialize with empty list', () {
      expect(notifier.state.value, isEmpty);
    });

    test('should update state with requests on successful fetch', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllRequests(testToken))
          .thenAnswer((_) async => testRequests);

      // Act
      await notifier.getAllRequests();

      // Assert
      expect(notifier.state.value, equals(testRequests));
      expect(notifier.state, isA<AsyncValue<List<RequestModel>>>());
      expect(notifier.state.isLoading, isFalse);
      verify(mockRepo.getAllRequests(testToken)).called(1);
    });

    test('should update state with error on fetch failure', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.getAllRequests(testToken)).thenAnswer((_) async => null);

      // Act
      await notifier.getAllRequests();

      // Assert
      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.error.toString(), contains('Failed to fetch requests'));
      verify(mockRepo.getAllRequests(testToken)).called(1);
    });

    test('should update state with error if not logged in', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(null); // No token

      // Act
      await notifier.getAllRequests();

      // Assert
      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.error.toString(), contains('Not logged in'));
      verifyNever(mockRepo.getAllRequests(any));
    });
  });

  group('RequestNotifier - createRequest', () {
    const testToken = 'test_token';
    final newRequestData = {'name': 'New Req', 'eventType': 'Event', 'amount': 300, 'status': 'pending'};
    final createdRequest = RequestModel(
      id: '3',
      user: {'_id': 'u3', 'name': 'User Three', 'email': 'u3@test.com'},
      name: 'New Req',
      eventType: 'Event',
      amount: 300,
      status: 'pending',
      createdAt: '2024-01-03T10:00:00Z',
    );

    test('should add new request to state on successful creation', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.createRequest(token: testToken, data: newRequestData))
          .thenAnswer((_) async => createdRequest);

      // Initialize with existing requests
      notifier.state = AsyncValue.data(testRequests);

      // Act
      final result = await notifier.createRequest(newRequestData);

      // Assert
      expect(result, isTrue);
      expect(notifier.state.value!.length, equals(testRequests.length + 1));
      expect(notifier.state.value!.first, equals(createdRequest)); // New request should be at the top
      verify(mockRepo.createRequest(token: testToken, data: newRequestData)).called(1);
    });

    test('should update state with error on creation failure', () async {
  // Arrange
  when(mockPrefs.getString(any)).thenReturn(testToken);
  when(mockRepo.createRequest(token: testToken, data: newRequestData))
      .thenThrow(Exception('Failed to create request from repo'));

  // Initialize with existing requests
  notifier.state = AsyncValue.data(testRequests);

  // Act
  try {
    final result = await notifier.createRequest(newRequestData);

    // Assert
    expect(result, isFalse);
    expect(notifier.state.hasError, isTrue);
    expect(notifier.state.error.toString(), contains('Failed to create request from repo'));
  } catch (_) {
    fail('Exception was not caught inside notifier');
  }
});


    test('should update state with error if not logged in during creation', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(null); // No token

      // Initialize with existing requests
      notifier.state = AsyncValue.data(testRequests);

      // Act
      final result = await notifier.createRequest(newRequestData);

      // Assert
      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.error.toString(), contains('Not logged in'));
      verifyNever(mockRepo.createRequest(token: anyNamed('token'), data: anyNamed('data')));
    });
  });

  group('RequestNotifier - updateRequestStatus', () {
    const testToken = 'test_token';
    const requestId = '1';
    const newStatus = 'completed';
    final updatedRequest = RequestModel(
      id: '1',
      user: {'_id': 'u1', 'name': 'User One', 'email': 'u1@test.com'},
      name: 'Req 1',
      eventType: 'Donation',
      amount: 100,
      status: newStatus,
      createdAt: '2024-01-01T10:00:00Z',
      updatedAt: '2024-01-01T11:00:00Z',
    );

    test('should refresh all requests on successful status update', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.updateRequestStatus(token: testToken, id: requestId, status: newStatus))
          .thenAnswer((_) async => updatedRequest);
      // Mock getAllRequests to be called after update
      when(mockRepo.getAllRequests(testToken))
          .thenAnswer((_) async => [updatedRequest, testRequests[1]]);

      // Initialize state with original requests
      notifier.state = AsyncValue.data(testRequests);

      // Act
      final result = await notifier.updateRequestStatus(requestId, newStatus);

      // Assert
      expect(result, isTrue);
      expect(notifier.state.value!.length, equals(2));
      expect(notifier.state.value![0].status, equals(newStatus));
      verify(mockRepo.updateRequestStatus(token: testToken, id: requestId, status: newStatus)).called(1);
      verify(mockRepo.getAllRequests(testToken)).called(1); // Should refresh
    });

    test('should update state with error on status update failure', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(testToken);
      when(mockRepo.updateRequestStatus(token: testToken, id: requestId, status: newStatus))
          .thenThrow(Exception('Failed to update status from repo'));

      // Initialize state with original requests
      notifier.state = AsyncValue.data(testRequests);

      // Act
      final result = await notifier.updateRequestStatus(requestId, newStatus);

      // Assert
      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.error.toString(), contains('Exception: Failed to update status from repo'));
      // State should remain unchanged (or indicate loading/error, not change data)
      // expect(notifier.state.value, equals(testRequests)); // Removed, as state.value will be null on error
      verify(mockRepo.updateRequestStatus(token: testToken, id: requestId, status: newStatus)).called(1);
      verifyNever(mockRepo.getAllRequests(any)); // Should not refresh on failure
    });

    test('should update state with error if not logged in during status update', () async {
      // Arrange
      when(mockPrefs.getString(any)).thenReturn(null); // No token

      // Initialize state with original requests
      notifier.state = AsyncValue.data(testRequests);

      // Act
      final result = await notifier.updateRequestStatus(requestId, newStatus);

      // Assert
      expect(result, isFalse);
      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.error.toString(), contains('Not logged in'));
      verifyNever(mockRepo.updateRequestStatus(token: anyNamed('token'), id: anyNamed('id'), status: anyNamed('status')));
      verifyNever(mockRepo.getAllRequests(any));
    });
  });
}
