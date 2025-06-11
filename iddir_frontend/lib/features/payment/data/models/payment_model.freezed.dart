// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) {
  return _PaymentModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentStatus')
  String? get paymentStatus => throw _privateConstructorUsedError;
  String? get paymentReceipt => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentApprovedAt')
  DateTime? get paymentApprovedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentModelCopyWith<PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentModelCopyWith<$Res> {
  factory $PaymentModelCopyWith(
    PaymentModel value,
    $Res Function(PaymentModel) then,
  ) = _$PaymentModelCopyWithImpl<$Res, PaymentModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String? name,
    String? email,
    @JsonKey(name: 'paymentStatus') String? paymentStatus,
    String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
  });
}

/// @nodoc
class _$PaymentModelCopyWithImpl<$Res, $Val extends PaymentModel>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? paymentStatus = freezed,
    Object? paymentReceipt = freezed,
    Object? paymentApprovedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentStatus:
                freezed == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentReceipt:
                freezed == paymentReceipt
                    ? _value.paymentReceipt
                    : paymentReceipt // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentApprovedAt:
                freezed == paymentApprovedAt
                    ? _value.paymentApprovedAt
                    : paymentApprovedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentModelImplCopyWith<$Res>
    implements $PaymentModelCopyWith<$Res> {
  factory _$$PaymentModelImplCopyWith(
    _$PaymentModelImpl value,
    $Res Function(_$PaymentModelImpl) then,
  ) = __$$PaymentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String? name,
    String? email,
    @JsonKey(name: 'paymentStatus') String? paymentStatus,
    String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
  });
}

/// @nodoc
class __$$PaymentModelImplCopyWithImpl<$Res>
    extends _$PaymentModelCopyWithImpl<$Res, _$PaymentModelImpl>
    implements _$$PaymentModelImplCopyWith<$Res> {
  __$$PaymentModelImplCopyWithImpl(
    _$PaymentModelImpl _value,
    $Res Function(_$PaymentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? paymentStatus = freezed,
    Object? paymentReceipt = freezed,
    Object? paymentApprovedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PaymentModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentStatus:
            freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentReceipt:
            freezed == paymentReceipt
                ? _value.paymentReceipt
                : paymentReceipt // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentApprovedAt:
            freezed == paymentApprovedAt
                ? _value.paymentApprovedAt
                : paymentApprovedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentModelImpl implements _PaymentModel {
  const _$PaymentModelImpl({
    @JsonKey(name: '_id') required this.id,
    required this.name,
    required this.email,
    @JsonKey(name: 'paymentStatus') required this.paymentStatus,
    this.paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') this.paymentApprovedAt,
    @JsonKey(name: 'createdAt') required this.createdAt,
  });

  factory _$PaymentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  @JsonKey(name: 'paymentStatus')
  final String? paymentStatus;
  @override
  final String? paymentReceipt;
  @override
  @JsonKey(name: 'paymentApprovedAt')
  final DateTime? paymentApprovedAt;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PaymentModel(id: $id, name: $name, email: $email, paymentStatus: $paymentStatus, paymentReceipt: $paymentReceipt, paymentApprovedAt: $paymentApprovedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentReceipt, paymentReceipt) ||
                other.paymentReceipt == paymentReceipt) &&
            (identical(other.paymentApprovedAt, paymentApprovedAt) ||
                other.paymentApprovedAt == paymentApprovedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    paymentStatus,
    paymentReceipt,
    paymentApprovedAt,
    createdAt,
  );

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentModelImplCopyWith<_$PaymentModelImpl> get copyWith =>
      __$$PaymentModelImplCopyWithImpl<_$PaymentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentModelImplToJson(this);
  }
}

abstract class _PaymentModel implements PaymentModel {
  const factory _PaymentModel({
    @JsonKey(name: '_id') required final String id,
    required final String? name,
    required final String? email,
    @JsonKey(name: 'paymentStatus') required final String? paymentStatus,
    final String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') final DateTime? paymentApprovedAt,
    @JsonKey(name: 'createdAt') required final DateTime? createdAt,
  }) = _$PaymentModelImpl;

  factory _PaymentModel.fromJson(Map<String, dynamic> json) =
      _$PaymentModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  @JsonKey(name: 'paymentStatus')
  String? get paymentStatus;
  @override
  String? get paymentReceipt;
  @override
  @JsonKey(name: 'paymentApprovedAt')
  DateTime? get paymentApprovedAt;
  @override
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentModelImplCopyWith<_$PaymentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentDetails _$PaymentDetailsFromJson(Map<String, dynamic> json) {
  return _PaymentDetails.fromJson(json);
}

/// @nodoc
mixin _$PaymentDetails {
  String? get paymentStatus => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  DateTime? get paymentApprovedAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentDetailsCopyWith<PaymentDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDetailsCopyWith<$Res> {
  factory $PaymentDetailsCopyWith(
    PaymentDetails value,
    $Res Function(PaymentDetails) then,
  ) = _$PaymentDetailsCopyWithImpl<$Res, PaymentDetails>;
  @useResult
  $Res call({
    String? paymentStatus,
    String? receiptUrl,
    DateTime? paymentApprovedAt,
  });
}

/// @nodoc
class _$PaymentDetailsCopyWithImpl<$Res, $Val extends PaymentDetails>
    implements $PaymentDetailsCopyWith<$Res> {
  _$PaymentDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentStatus = freezed,
    Object? receiptUrl = freezed,
    Object? paymentApprovedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            paymentStatus:
                freezed == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            receiptUrl:
                freezed == receiptUrl
                    ? _value.receiptUrl
                    : receiptUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentApprovedAt:
                freezed == paymentApprovedAt
                    ? _value.paymentApprovedAt
                    : paymentApprovedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentDetailsImplCopyWith<$Res>
    implements $PaymentDetailsCopyWith<$Res> {
  factory _$$PaymentDetailsImplCopyWith(
    _$PaymentDetailsImpl value,
    $Res Function(_$PaymentDetailsImpl) then,
  ) = __$$PaymentDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? paymentStatus,
    String? receiptUrl,
    DateTime? paymentApprovedAt,
  });
}

/// @nodoc
class __$$PaymentDetailsImplCopyWithImpl<$Res>
    extends _$PaymentDetailsCopyWithImpl<$Res, _$PaymentDetailsImpl>
    implements _$$PaymentDetailsImplCopyWith<$Res> {
  __$$PaymentDetailsImplCopyWithImpl(
    _$PaymentDetailsImpl _value,
    $Res Function(_$PaymentDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentStatus = freezed,
    Object? receiptUrl = freezed,
    Object? paymentApprovedAt = freezed,
  }) {
    return _then(
      _$PaymentDetailsImpl(
        paymentStatus:
            freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        receiptUrl:
            freezed == receiptUrl
                ? _value.receiptUrl
                : receiptUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentApprovedAt:
            freezed == paymentApprovedAt
                ? _value.paymentApprovedAt
                : paymentApprovedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentDetailsImpl implements _PaymentDetails {
  const _$PaymentDetailsImpl({
    required this.paymentStatus,
    this.receiptUrl,
    this.paymentApprovedAt,
  });

  factory _$PaymentDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentDetailsImplFromJson(json);

  @override
  final String? paymentStatus;
  @override
  final String? receiptUrl;
  @override
  final DateTime? paymentApprovedAt;

  @override
  String toString() {
    return 'PaymentDetails(paymentStatus: $paymentStatus, receiptUrl: $receiptUrl, paymentApprovedAt: $paymentApprovedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDetailsImpl &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.paymentApprovedAt, paymentApprovedAt) ||
                other.paymentApprovedAt == paymentApprovedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paymentStatus, receiptUrl, paymentApprovedAt);

  /// Create a copy of PaymentDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDetailsImplCopyWith<_$PaymentDetailsImpl> get copyWith =>
      __$$PaymentDetailsImplCopyWithImpl<_$PaymentDetailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentDetailsImplToJson(this);
  }
}

abstract class _PaymentDetails implements PaymentDetails {
  const factory _PaymentDetails({
    required final String? paymentStatus,
    final String? receiptUrl,
    final DateTime? paymentApprovedAt,
  }) = _$PaymentDetailsImpl;

  factory _PaymentDetails.fromJson(Map<String, dynamic> json) =
      _$PaymentDetailsImpl.fromJson;

  @override
  String? get paymentStatus;
  @override
  String? get receiptUrl;
  @override
  DateTime? get paymentApprovedAt;

  /// Create a copy of PaymentDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDetailsImplCopyWith<_$PaymentDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentStatistics _$PaymentStatisticsFromJson(Map<String, dynamic> json) {
  return _PaymentStatistics.fromJson(json);
}

/// @nodoc
mixin _$PaymentStatistics {
  double get inBank => throw _privateConstructorUsedError;
  double get overdue => throw _privateConstructorUsedError;
  double get pending => throw _privateConstructorUsedError;

  /// Serializes this PaymentStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentStatisticsCopyWith<PaymentStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStatisticsCopyWith<$Res> {
  factory $PaymentStatisticsCopyWith(
    PaymentStatistics value,
    $Res Function(PaymentStatistics) then,
  ) = _$PaymentStatisticsCopyWithImpl<$Res, PaymentStatistics>;
  @useResult
  $Res call({double inBank, double overdue, double pending});
}

/// @nodoc
class _$PaymentStatisticsCopyWithImpl<$Res, $Val extends PaymentStatistics>
    implements $PaymentStatisticsCopyWith<$Res> {
  _$PaymentStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inBank = null,
    Object? overdue = null,
    Object? pending = null,
  }) {
    return _then(
      _value.copyWith(
            inBank:
                null == inBank
                    ? _value.inBank
                    : inBank // ignore: cast_nullable_to_non_nullable
                        as double,
            overdue:
                null == overdue
                    ? _value.overdue
                    : overdue // ignore: cast_nullable_to_non_nullable
                        as double,
            pending:
                null == pending
                    ? _value.pending
                    : pending // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentStatisticsImplCopyWith<$Res>
    implements $PaymentStatisticsCopyWith<$Res> {
  factory _$$PaymentStatisticsImplCopyWith(
    _$PaymentStatisticsImpl value,
    $Res Function(_$PaymentStatisticsImpl) then,
  ) = __$$PaymentStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double inBank, double overdue, double pending});
}

/// @nodoc
class __$$PaymentStatisticsImplCopyWithImpl<$Res>
    extends _$PaymentStatisticsCopyWithImpl<$Res, _$PaymentStatisticsImpl>
    implements _$$PaymentStatisticsImplCopyWith<$Res> {
  __$$PaymentStatisticsImplCopyWithImpl(
    _$PaymentStatisticsImpl _value,
    $Res Function(_$PaymentStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inBank = null,
    Object? overdue = null,
    Object? pending = null,
  }) {
    return _then(
      _$PaymentStatisticsImpl(
        inBank:
            null == inBank
                ? _value.inBank
                : inBank // ignore: cast_nullable_to_non_nullable
                    as double,
        overdue:
            null == overdue
                ? _value.overdue
                : overdue // ignore: cast_nullable_to_non_nullable
                    as double,
        pending:
            null == pending
                ? _value.pending
                : pending // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentStatisticsImpl implements _PaymentStatistics {
  const _$PaymentStatisticsImpl({
    required this.inBank,
    required this.overdue,
    required this.pending,
  });

  factory _$PaymentStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentStatisticsImplFromJson(json);

  @override
  final double inBank;
  @override
  final double overdue;
  @override
  final double pending;

  @override
  String toString() {
    return 'PaymentStatistics(inBank: $inBank, overdue: $overdue, pending: $pending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentStatisticsImpl &&
            (identical(other.inBank, inBank) || other.inBank == inBank) &&
            (identical(other.overdue, overdue) || other.overdue == overdue) &&
            (identical(other.pending, pending) || other.pending == pending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inBank, overdue, pending);

  /// Create a copy of PaymentStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentStatisticsImplCopyWith<_$PaymentStatisticsImpl> get copyWith =>
      __$$PaymentStatisticsImplCopyWithImpl<_$PaymentStatisticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentStatisticsImplToJson(this);
  }
}

abstract class _PaymentStatistics implements PaymentStatistics {
  const factory _PaymentStatistics({
    required final double inBank,
    required final double overdue,
    required final double pending,
  }) = _$PaymentStatisticsImpl;

  factory _PaymentStatistics.fromJson(Map<String, dynamic> json) =
      _$PaymentStatisticsImpl.fromJson;

  @override
  double get inBank;
  @override
  double get overdue;
  @override
  double get pending;

  /// Create a copy of PaymentStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentStatisticsImplCopyWith<_$PaymentStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
