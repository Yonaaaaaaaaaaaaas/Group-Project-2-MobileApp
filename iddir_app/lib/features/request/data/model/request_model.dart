import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
class RequestModel with _$RequestModel {
  const factory RequestModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'user') dynamic user,
    required String name,
    required String eventType,
    required int amount,
    required String status,
    String? createdAt,
    String? updatedAt,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension RequestModelUser on RequestModel {
  UserModel? get userModel {
    if (user is Map<String, dynamic>) {
      return UserModel.fromJson(user as Map<String, dynamic>);
    }
    return null;
  }
}