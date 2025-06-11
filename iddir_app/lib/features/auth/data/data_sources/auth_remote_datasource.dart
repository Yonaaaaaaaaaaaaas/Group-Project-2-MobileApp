import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource(this.dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      print('Login response: ${response.data}');
      return response.data; // contains 'token' and 'user'
    } on DioException catch (e) {
      print('Login error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw 'Invalid email or password';
      }
      throw 'Login failed: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/auth/register', data: data);
      print('Register response: ${response.data}');
      return response.data; // contains 'token' and 'user'
    } on DioException catch (e) {
      print('Register error: ${e.response?.data}');
      throw 'Registration failed: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<UserModel> getMe(String token) async {
    try {
      final response = await dio.get('/auth/me', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      print('GetMe error: ${e.response?.data}');
      throw 'Failed to get user data: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }
}