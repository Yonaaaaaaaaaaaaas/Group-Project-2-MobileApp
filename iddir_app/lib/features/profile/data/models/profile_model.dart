import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
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
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

extension ProfileModelExtension on ProfileModel {
  String? get fullProfilePictureUrl {
    if (profilePicture == null) return null;
    final baseUrl = 'http://localhost:5000'; // Replace with your actual base URL
    final imagePath = profilePicture!.replaceAll('\\', '/');
    return '$baseUrl/public$imagePath';
  }
}
