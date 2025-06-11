import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../models/users_model.dart';
import '../data_sources/users_remote_datasource.dart';

part 'users_repository.g.dart';

@riverpod
class UsersRepository extends _$UsersRepository {
  late final UsersRemoteDatasource _datasource;

  @override
  UsersRemoteDatasource build(Dio dio) {
    _datasource = UsersRemoteDatasource(dio);
    return _datasource;
  }

  Future<List<UsersModel>?> getAllUsers({required String token}) async {
    try {
      return await _datasource.getAllUsers(token);
    } catch (e) {
      return null;
    }
  }

  Future<UsersModel?> getUser({
    required String token,
    required String userId,
  }) async {
    try {
      return await _datasource.getUser(token, userId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteUser({required String token, required String userId}) async {
    try {
      return await _datasource.deleteUser(token: token, userId: userId);
    } catch (e) {
      return false;
    }
  }
}
