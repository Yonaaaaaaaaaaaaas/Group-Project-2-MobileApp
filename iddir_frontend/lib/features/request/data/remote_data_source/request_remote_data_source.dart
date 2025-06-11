import 'package:dio/dio.dart';
import '../model/request_model.dart';
class RequestRemoteDataSource {
  final Dio dio;
  RequestRemoteDataSource(this.dio);

  // Get all requests (admin)
  Future<List<RequestModel>> getAllRequests(String token) async {
    try {
      final response = await dio.get(
        '/requests',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final List<dynamic> data = response.data;
      print(response.data);
      return data.map((json) => RequestModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print('GetAllRequests error: ${e.response?.data}');
      throw Exception('Failed to get requests: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Create a new request (user)
  Future<RequestModel> createRequest(String token, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        '/requests',
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RequestModel.fromJson(response.data);
    } on DioException catch (e) {
      print('CreateRequest error: ${e.response?.data}');
      throw Exception('Failed to create request: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Update request status (admin)
  Future<RequestModel> updateRequestStatus(
      String token, String id, String status) async {
    try {
      final response = await dio.put(
        '/requests/$id',
        data: {'status': status},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RequestModel.fromJson(response.data);
    } on DioException catch (e) {
      print('UpdateRequestStatus error: ${e.response?.data}');
      throw Exception('Failed to update request: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}