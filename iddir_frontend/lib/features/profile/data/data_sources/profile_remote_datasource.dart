import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

class ProfileRemoteDatasource {
  final Dio dio;
  ProfileRemoteDatasource(this.dio);

  Future<ProfileModel> getProfile(String token) async {
    try {
      final response = await dio.get('/profile', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      print('ProfileRemoteDatasource: getProfile response: ${response.data}');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      print('GetProfile error: ${e.response?.data}');
      throw 'Failed to get profile data: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<ProfileModel> updateProfile(String token, Map<String, dynamic> data) async {
    try {
      final response = await dio.put('/profile', 
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return ProfileModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      print('UpdateProfile error: ${e.response?.data}');
      throw 'Failed to update profile: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<String> updateProfilePicture(String token, dynamic imageData) async {
    try {
      print('Sending profile picture update request...');
      final response = await dio.put('/profile/picture',
        data: imageData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      
      print('UpdateProfilePicture response: ${response.data}');
      
      if (response.data['profilePicture'] == null) {
        throw 'Failed to get profile picture URL from response';
      }
      
      // Convert backslashes to forward slashes and ensure proper URL construction
      final imagePath = response.data['profilePicture'].toString().replaceAll('\\', '/');
      final baseUrl = dio.options.baseUrl;
      return '$baseUrl/public$imagePath';
    } on DioException catch (e) {
      print('UpdateProfilePicture error: ${e.response?.data}');
      print('Error status code: ${e.response?.statusCode}');
      print('Error message: ${e.message}');
      throw 'Failed to update profile picture: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<bool> deleteAccount(String token) async {
    try {
      await dio.delete('/profile', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      return true;
    } on DioException catch (e) {
      print('DeleteAccount error: ${e.response?.data}');
      throw 'Failed to delete account: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }
}


