// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsersModelImpl _$$UsersModelImplFromJson(Map<String, dynamic> json) =>
    _$UsersModelImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      profilePicture: json['profilePicture'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      paymentReceipt: json['paymentReceipt'] as String?,
      paymentApprovedAt:
          json['paymentApprovedAt'] == null
              ? null
              : DateTime.parse(json['paymentApprovedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UsersModelImplToJson(_$UsersModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'role': instance.role,
      'profilePicture': instance.profilePicture,
      'paymentStatus': instance.paymentStatus,
      'paymentReceipt': instance.paymentReceipt,
      'paymentApprovedAt': instance.paymentApprovedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
