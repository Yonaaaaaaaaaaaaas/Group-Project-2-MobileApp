import 'package:dio/dio.dart';
import '../models/announcement_model.dart';

class AnnouncementRemoteDatasource {
  final Dio dio;
  AnnouncementRemoteDatasource(this.dio);

  // Get all announcements
  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    try {
      final response = await dio.get('/announcements');
      final List<dynamic> data = response.data;
      return data.map((json) => AnnouncementModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print('GetAllAnnouncements error: ${e.response?.data}');
      throw 'Failed to get announcements: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  // Create announcement (admin only)
  Future<AnnouncementModel> createAnnouncement(String token, Map<String, dynamic> data, dynamic imageData) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        if (imageData != null) 'image': imageData,
      });

      final response = await dio.post(
        '/announcements',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('CreateAnnouncement response: ${response.data}');
      return AnnouncementModel.fromJson(response.data);
    } on DioException catch (e) {
      print('CreateAnnouncement error: ${e.response?.data}');
      throw 'Failed to create announcement: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  // Update announcement (admin only)
  Future<AnnouncementModel> updateAnnouncement(String token, String id, Map<String, dynamic> data, dynamic imageData) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        if (imageData != null) 'image': imageData,
      });

      final response = await dio.put(
        '/announcements/$id',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return AnnouncementModel.fromJson(response.data);
    } on DioException catch (e) {
      print('UpdateAnnouncement error: ${e.response?.data}');
      throw 'Failed to update announcement: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  // Delete announcement (admin only)
  Future<bool> deleteAnnouncement(String token, String id) async {
    try {
      await dio.delete(
        '/announcements/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return true;
    } on DioException catch (e) {
      print('DeleteAnnouncement error: ${e.response?.data}');
      throw 'Failed to delete announcement: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }
}
