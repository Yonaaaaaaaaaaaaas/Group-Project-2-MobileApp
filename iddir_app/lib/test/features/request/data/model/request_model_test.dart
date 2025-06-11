import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';



void main() {
  group('RequestModel', () {
    test('should create a model with all fields', () {
      final model = RequestModel(
        id: 'req123',
        user: {'_id': 'user456', 'name': 'John Doe', 'email': 'john.doe@example.com'},
        name: 'John Doe',
        eventType: 'Donation',
        amount: 500,
        status: 'pending',
        createdAt: '2024-01-01T10:00:00Z',
        updatedAt: '2024-01-01T11:00:00Z',
      );

      expect(model.id, 'req123');
      expect(model.name, 'John Doe');
      expect(model.eventType, 'Donation');
      expect(model.amount, 500);
      expect(model.status, 'pending');
      expect(model.createdAt, '2024-01-01T10:00:00Z');
      expect(model.updatedAt, '2024-01-01T11:00:00Z');
      expect(model.user, isA<Map<String, dynamic>>());
    });

    test('should create a model without optional fields', () {
      final model = RequestModel(
        id: 'req123',
        user: {'_id': 'user456', 'name': 'John Doe', 'email': 'john.doe@example.com'},
        name: 'Jane Doe',
        eventType: 'Funeral',
        amount: 1000,
        status: 'approved',
      );

      expect(model.id, 'req123');
      expect(model.name, 'Jane Doe');
      expect(model.eventType, 'Funeral');
      expect(model.amount, 1000);
      expect(model.status, 'approved');
      expect(model.createdAt, isNull);
      expect(model.updatedAt, isNull);
      expect(model.user, isA<Map<String, dynamic>>());
    });

    test('should serialize and deserialize JSON correctly with all fields', () {
      final json = {
        '_id': 'req123',
        'user': {'_id': 'user456', 'name': 'John Doe', 'email': 'john.doe@example.com'},
        'name': 'Test Request',
        'eventType': 'Wedding',
        'amount': 2000,
        'status': 'completed',
        'createdAt': '2024-02-01T12:00:00Z',
        'updatedAt': '2024-02-01T13:00:00Z',
      };

      final model = RequestModel.fromJson(json);
      final serialized = model.toJson();

      // Verify deserialization
      expect(model.id, 'req123');
      expect(model.user, isA<Map<String, dynamic>>());
      expect(model.name, 'Test Request');
      expect(model.eventType, 'Wedding');
      expect(model.amount, 2000);
      expect(model.status, 'completed');
      expect(model.createdAt, '2024-02-01T12:00:00Z');
      expect(model.updatedAt, '2024-02-01T13:00:00Z');

      // Verify serialization
      expect(serialized['_id'], json['_id']);
      expect(serialized['user'], json['user']);
      expect(serialized['name'], json['name']);
      expect(serialized['eventType'], json['eventType']);
      expect(serialized['amount'], json['amount']);
      expect(serialized['status'], json['status']);
      expect(serialized['createdAt'], json['createdAt']);
      expect(serialized['updatedAt'], json['updatedAt']);
    });

    test('should serialize and deserialize JSON correctly without optional fields', () {
      final json = {
        '_id': 'req456',
        'user': {'_id': 'user789', 'name': 'Bob Smith', 'email': 'bob.smith@example.com'},
        'name': 'Another Request',
        'eventType': 'Maintenance',
        'amount': 1500,
        'status': 'pending',
      };

      final model = RequestModel.fromJson(json);
      final serialized = model.toJson();

      // Verify deserialization
      expect(model.id, 'req456');
      expect(model.user, isA<Map<String, dynamic>>());
      expect(model.name, 'Another Request');
      expect(model.eventType, 'Maintenance');
      expect(model.amount, 1500);
      expect(model.status, 'pending');
      expect(model.createdAt, isNull);
      expect(model.updatedAt, isNull);

      // Verify serialization
      expect(serialized['_id'], json['_id']);
      expect(serialized['user'], json['user']);
      expect(serialized['name'], json['name']);
      expect(serialized['eventType'], json['eventType']);
      expect(serialized['amount'], json['amount']);
      expect(serialized['status'], json['status']);
      expect(serialized['createdAt'], isNull);
      expect(serialized['updatedAt'], isNull);
    });

    test('should handle JSON with _id field', () {
      final json = {
        '_id': 'someId',
        'name': 'Another Request',
        'eventType': 'Birth',
        'amount': 750,
        'status': 'pending',
      };
      final model = RequestModel.fromJson(json);
      expect(model.id, 'someId'); // Should map _id to id
    });
  });

  group('RequestModelUserExtension', () {
    test('should return UserModel when user is a map', () {
      final model = RequestModel(
        id: 'req1',
        user: {'_id': 'u1', 'name': 'Alice', 'email': 'alice@example.com'},
        name: 'Alice Request',
        eventType: 'General',
        amount: 100,
        status: 'new',
      );
      final userModel = model.userModel;
      expect(userModel, isNotNull);
      expect(userModel!.id, 'u1');
      expect(userModel.name, 'Alice');
      expect(userModel.email, 'alice@example.com');
    });

    test('should return null when user is null', () {
      final model = RequestModel(
        id: 'req2',
        user: null,
        name: 'Bob Request',
        eventType: 'Maintenance',
        amount: 200,
        status: 'in progress',
      );
      final userModel = model.userModel;
      expect(userModel, isNull);
    });

    test('should return null when user is not a map', () {
      final model = RequestModel(
        id: 'req3',
        user: 'some_string_user_id', // Simulate a case where user might be just an ID string
        name: 'Charlie Request',
        eventType: 'Donation',
        amount: 300,
        status: 'completed',
      );
      final userModel = model.userModel;
      expect(userModel, isNull);
    });
  });
}