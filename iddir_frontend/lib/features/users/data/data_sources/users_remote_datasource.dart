import 'package:dio/dio.dart';
import '../models/users_model.dart';

class UsersRemoteDatasource {
  final Dio dio;
  UsersRemoteDatasource(this.dio);

  Future<List<UsersModel>> getAllUsers(String token) async {
    try {
      final response = await dio.get('/users', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      
      final List<dynamic> usersJson = response.data;
      return usersJson.map((json) => UsersModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print('GetAllUsers error: ${e.response?.data}');
      throw 'Failed to get users data: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<UsersModel> getUser(String token, String userId) async {
    try {
      final response = await dio.get('/users/$userId', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      
      return UsersModel.fromJson(response.data);
    } on DioException catch (e) {
      print('GetUser error: ${e.response?.data}');
      throw 'Failed to get user data: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<bool> deleteUser({required String token, required String userId}) async {
    try {
      await dio.delete(
        '/users/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return true;
    } on DioException catch (e) {
      print('DeleteUser error: ${e.response?.data}');
      throw 'Failed to delete user: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }
}
