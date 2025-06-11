// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      id: json['_id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      paymentReceipt: json['paymentReceipt'] as String?,
      paymentApprovedAt:
          json['paymentApprovedAt'] == null
              ? null
              : DateTime.parse(json['paymentApprovedAt'] as String),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'paymentStatus': instance.paymentStatus,
      'paymentReceipt': instance.paymentReceipt,
      'paymentApprovedAt': instance.paymentApprovedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$PaymentDetailsImpl _$$PaymentDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PaymentDetailsImpl(
      paymentStatus: json['paymentStatus'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      paymentApprovedAt:
          json['paymentApprovedAt'] == null
              ? null
              : DateTime.parse(json['paymentApprovedAt'] as String),
    );

Map<String, dynamic> _$$PaymentDetailsImplToJson(
  _$PaymentDetailsImpl instance,
) => <String, dynamic>{
  'paymentStatus': instance.paymentStatus,
  'receiptUrl': instance.receiptUrl,
  'paymentApprovedAt': instance.paymentApprovedAt?.toIso8601String(),
};

_$PaymentStatisticsImpl _$$PaymentStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentStatisticsImpl(
  inBank: (json['inBank'] as num).toDouble(),
  overdue: (json['overdue'] as num).toDouble(),
  pending: (json['pending'] as num).toDouble(),
);

Map<String, dynamic> _$$PaymentStatisticsImplToJson(
  _$PaymentStatisticsImpl instance,
) => <String, dynamic>{
  'inBank': instance.inBank,
  'overdue': instance.overdue,
  'pending': instance.pending,
};
