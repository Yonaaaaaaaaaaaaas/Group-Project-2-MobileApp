import 'package:iddir_app/features/request/data/model/request_model.dart';
import 'package:iddir_app/features/request/data/remote_data_source/request_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'request_repository.g.dart';

@riverpod
class RequestRepository extends _$RequestRepository {
  late final RequestRemoteDataSource _remoteDataSource;

  @override
  RequestRemoteDataSource build(Dio dio) {
    _remoteDataSource = RequestRemoteDataSource(dio);
    return _remoteDataSource;
  }

  Future<List<RequestModel>?> getAllRequests(String token) async {
    try {
      return await _remoteDataSource.getAllRequests(token);
    } catch (e) {
      return null;
    }
  }

  Future<RequestModel?> createRequest({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _remoteDataSource.createRequest(token, data);
    } catch (e) {
      return null;
    }
  }

  Future<RequestModel?> updateRequestStatus({
    required String token,
    required String id,
    required String status,
  }) async {
    try {
      return await _remoteDataSource.updateRequestStatus(token, id, status);
    } catch (e) {
      return null;
    }
  }
}
