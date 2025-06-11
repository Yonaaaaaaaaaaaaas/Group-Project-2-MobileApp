import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import '../data_sources/profile_remote_datasource.dart';

part 'profile_repository.g.dart';

@riverpod
class ProfileRepository extends _$ProfileRepository {
  late final ProfileRemoteDatasource _datasource;

  @override
  ProfileRemoteDatasource build(Dio dio) {
    _datasource = ProfileRemoteDatasource(dio);
    return _datasource;
  }

  Future<ProfileModel?> getProfile({required String token}) async {
    try {
      return await _datasource.getProfile(token);
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel?> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _datasource.updateProfile(token, data);
    } catch (e) {
      return null;
    }
  }

  Future<String?> updateProfilePicture({
    required String token,
    required dynamic imageData,
  }) async {
    try {
      return await _datasource.updateProfilePicture(token, imageData);
    } catch (e) {
      return null;
    }
  }


  Future<bool> deleteAccount({required String token}) async {
  try {
    return await _datasource.deleteAccount(token);
  } catch (e) {
    return false;
  }
}
}


