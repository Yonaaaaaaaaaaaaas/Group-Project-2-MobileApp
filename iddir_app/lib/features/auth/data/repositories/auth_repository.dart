import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../data_sources/auth_remote_datasource.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  late final AuthRemoteDatasource _datasource;

  @override
  AuthRemoteDatasource build(Dio dio) {
    _datasource = AuthRemoteDatasource(dio);
    return _datasource;
  }

  Future<Map<String, dynamic>?> login({required String email, required String password}) async {
    try {
      return await _datasource.login(email, password);
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> register({required Map<String, dynamic> data}) async {
    try {
      return await _datasource.register(data);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getMe({required String token}) async {
    try {
      return await _datasource.getMe(token);
    } catch (e) {
      return null;
    }
  }
}