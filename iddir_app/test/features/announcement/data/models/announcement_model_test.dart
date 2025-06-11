import 'package:flutter_test/flutter_test.dart';
import 'package:iddir_app/features/announcement/data/models/announcement_model.dart';

void main() {
  group('AnnouncementModel Tests', () {
    final testDate = DateTime.parse('2024-03-20T10:00:00Z');
    final testCreatedAt = DateTime.parse('2024-03-19T10:00:00Z');
    final testUpdatedAt = DateTime.parse('2024-03-19T10:00:00Z');

    final testPostedBy = PostedByModel(id: '123', name: 'Test User');

    final testAnnouncement = AnnouncementModel(
      id: '1',
      title: 'Test Announcement',
      description: 'Test Description',
      date: testDate,
      location: 'Test Location',
      image: '/images/test.jpg',
      postedBy: testPostedBy,
      createdAt: testCreatedAt,
      updatedAt: testUpdatedAt,
    );

    test('should create AnnouncementModel instance with all fields', () {
      expect(testAnnouncement.id, equals('1'));
      expect(testAnnouncement.title, equals('Test Announcement'));
      expect(testAnnouncement.description, equals('Test Description'));
      expect(testAnnouncement.date, equals(testDate));
      expect(testAnnouncement.location, equals('Test Location'));
      expect(testAnnouncement.image, equals('/images/test.jpg'));
      expect(testAnnouncement.postedBy, equals(testPostedBy));
      expect(testAnnouncement.createdAt, equals(testCreatedAt));
      expect(testAnnouncement.updatedAt, equals(testUpdatedAt));
    });

    test('should create AnnouncementModel instance with null image', () {
      final announcementWithoutImage = AnnouncementModel(
        id: '1',
        title: 'Test Announcement',
        description: 'Test Description',
        date: testDate,
        location: 'Test Location',
        image: null,
        postedBy: testPostedBy,
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
      );

      expect(announcementWithoutImage.image, isNull);
    });

    test('should convert AnnouncementModel to JSON and back', () {
      final json = {
        '_id': '1',
        'title': 'Test Announcement',
        'description': 'Test Description',
        'date': '2024-03-20T10:00:00Z',
        'location': 'Test Location',
        'image': '/images/test.jpg',
        'postedBy': {
          '_id': '123',
          'name': 'Test User',
        },
        'createdAt': '2024-03-19T10:00:00Z',
        'updatedAt': '2024-03-19T10:00:00Z',
      };

      final fromJson = AnnouncementModel.fromJson(json);
      expect(fromJson, equals(testAnnouncement));
    });

    test('should handle postedBy as string in JSON', () {
      final json = {
        '_id': '1',
        'title': 'Test Announcement',
        'description': 'Test Description',
        'date': '2024-03-20T10:00:00Z',
        'location': 'Test Location',
        'image': '/images/test.jpg',
        'postedBy': '123',
        'createdAt': '2024-03-19T10:00:00Z',
        'updatedAt': '2024-03-19T10:00:00Z',
      };

      final fromJson = AnnouncementModel.fromJson(json);
      expect(fromJson.postedBy.id, equals('123'));
      expect(fromJson.postedBy.name, equals(''));
    });

    test('should throw exception for invalid postedBy type', () {
      final json = {
        '_id': '1',
        'title': 'Test Announcement',
        'description': 'Test Description',
        'date': '2024-03-20T10:00:00Z',
        'location': 'Test Location',
        'image': '/images/test.jpg',
        'postedBy': 123, // Invalid type
        'createdAt': '2024-03-19T10:00:00Z',
        'updatedAt': '2024-03-19T10:00:00Z',
      };

      expect(() => AnnouncementModel.fromJson(json), throwsException);
    });

    group('fullImageUrl extension', () {
      test('should return correct full image URL', () {
        expect(
          testAnnouncement.fullImageUrl,
          equals('http://localhost:5000/public/images/test.jpg'),
        );
      });

      test('should handle backslashes in image path', () {
        final announcementWithBackslashes = AnnouncementModel(
          id: '1',
          title: 'Test Announcement',
          description: 'Test Description',
          date: testDate,
          location: 'Test Location',
          image: '\\images\\test.jpg',
          postedBy: testPostedBy,
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
        );

        expect(
          announcementWithBackslashes.fullImageUrl,
          equals('http://localhost:5000/public/images/test.jpg'),
        );
      });

      test('should return null when image is null', () {
        final announcementWithoutImage = AnnouncementModel(
          id: '1',
          title: 'Test Announcement',
          description: 'Test Description',
          date: testDate,
          location: 'Test Location',
          image: null,
          postedBy: testPostedBy,
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
        );

        expect(announcementWithoutImage.fullImageUrl, isNull);
      });
    });

    group('PostedByModel Tests', () {
      test('should create PostedByModel instance', () {
        expect(testPostedBy.id, equals('123'));
        expect(testPostedBy.name, equals('Test User'));
      });

      test('should convert PostedByModel to JSON and back', () {
        final json = {
          '_id': '123',
          'name': 'Test User',
        };

        final fromJson = PostedByModel.fromJson(json);
        expect(fromJson, equals(testPostedBy));
      });
    });
  });
}
