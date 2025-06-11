import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'users_model.freezed.dart';
part 'users_model.g.dart';

@freezed
class UsersModel with _$UsersModel {
  const factory UsersModel({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    required String address,
    required String phone,
    required String role,
    String? profilePicture,
    @JsonKey(name: 'paymentStatus') String? paymentStatus,
    @JsonKey(name: 'paymentReceipt') String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _UsersModel;

  factory UsersModel.fromJson(Map<String, dynamic> json) => _$UsersModelFromJson(json);
}

extension UsersModelExtension on UsersModel {
  String? get fullProfilePictureUrl {
    if (profilePicture == null) return null;
    final baseUrl = 'http://localhost:5000'; // Replace with your actual base URL
    final imagePath = profilePicture!.replaceAll('\\', '/');
    return '$baseUrl/public$imagePath';
  }
}
