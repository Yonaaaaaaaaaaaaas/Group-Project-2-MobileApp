import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../models/announcement_model.dart';
import '../data_sources/announcement_remote_datasource.dart';

part 'announcement_repository.g.dart';

@riverpod
class AnnouncementRepository extends _$AnnouncementRepository {
  late final AnnouncementRemoteDatasource _datasource;

  @override
  AnnouncementRemoteDatasource build(Dio dio) {
    _datasource = AnnouncementRemoteDatasource(dio);
    return _datasource;
  }

  Future<List<AnnouncementModel>?> getAllAnnouncements() async {
    try {
      return await _datasource.getAllAnnouncements();
    } catch (e) {
      return null;
    }
  }

  Future<AnnouncementModel?> createAnnouncement({
    required String token,
    required Map<String, dynamic> data,
    required dynamic imageData,
  }) async {
    try {
      return await _datasource.createAnnouncement(token, data, imageData);
    } catch (e) {
      return null;
    }
  }

  Future<AnnouncementModel?> updateAnnouncement({
    required String token,
    required String id,
    required Map<String, dynamic> data,
    required dynamic imageData,
  }) async {
    try {
      return await _datasource.updateAnnouncement(token, id, data, imageData);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteAnnouncement({
    required String token,
    required String id,
  }) async {
    try {
      return await _datasource.deleteAnnouncement(token, id);
    } catch (e) {
      return false;
    }
  }
}
