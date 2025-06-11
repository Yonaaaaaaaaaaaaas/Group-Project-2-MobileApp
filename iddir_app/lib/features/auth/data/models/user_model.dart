import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'id') required String id,
    required String name,
    required String email,
    required String role,
  }) = _UserModel;

  /// Add this to enable toJson
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

