// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentStatus')
  String? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentReceipt')
  String? get paymentReceipt => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentApprovedAt')
  DateTime? get paymentApprovedAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
    ProfileModel value,
    $Res Function(ProfileModel) then,
  ) = _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String name,
    String email,
    String address,
    String phone,
    String role,
    String? profilePicture,
    @JsonKey(name: 'paymentStatus') String? paymentStatus,
    @JsonKey(name: 'paymentReceipt') String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
  });
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? address = null,
    Object? phone = null,
    Object? role = null,
    Object? profilePicture = freezed,
    Object? paymentStatus = freezed,
    Object? paymentReceipt = freezed,
    Object? paymentApprovedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            phone:
                null == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String,
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as String,
            profilePicture:
                freezed == profilePicture
                    ? _value.profilePicture
                    : profilePicture // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
    _$ProfileModelImpl value,
    $Res Function(_$ProfileModelImpl) then,
  ) = __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String name,
    String email,
    String address,
    String phone,
    String role,
    String? profilePicture,
    @JsonKey(name: 'paymentStatus') String? paymentStatus,
    @JsonKey(name: 'paymentReceipt') String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
  });
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
    _$ProfileModelImpl _value,
    $Res Function(_$ProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? address = null,
    Object? phone = null,
    Object? role = null,
    Object? profilePicture = freezed,
    Object? paymentStatus = freezed,
    Object? paymentReceipt = freezed,
    Object? paymentApprovedAt = freezed,
  }) {
    return _then(
      _$ProfileModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        phone:
            null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String,
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as String,
        profilePicture:
            freezed == profilePicture
                ? _value.profilePicture
                : profilePicture // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl({
    @JsonKey(name: '_id') required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.role,
    this.profilePicture,
    @JsonKey(name: 'paymentStatus') this.paymentStatus,
    @JsonKey(name: 'paymentReceipt') this.paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') this.paymentApprovedAt,
  });

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String role;
  @override
  final String? profilePicture;
  @override
  @JsonKey(name: 'paymentStatus')
  final String? paymentStatus;
  @override
  @JsonKey(name: 'paymentReceipt')
  final String? paymentReceipt;
  @override
  @JsonKey(name: 'paymentApprovedAt')
  final DateTime? paymentApprovedAt;

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, address: $address, phone: $phone, role: $role, profilePicture: $profilePicture, paymentStatus: $paymentStatus, paymentReceipt: $paymentReceipt, paymentApprovedAt: $paymentApprovedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentReceipt, paymentReceipt) ||
                other.paymentReceipt == paymentReceipt) &&
            (identical(other.paymentApprovedAt, paymentApprovedAt) ||
                other.paymentApprovedAt == paymentApprovedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    address,
    phone,
    role,
    profilePicture,
    paymentStatus,
    paymentReceipt,
    paymentApprovedAt,
  );

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(this);
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel({
    @JsonKey(name: '_id') required final String id,
    required final String name,
    required final String email,
    required final String address,
    required final String phone,
    required final String role,
    final String? profilePicture,
    @JsonKey(name: 'paymentStatus') final String? paymentStatus,
    @JsonKey(name: 'paymentReceipt') final String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') final DateTime? paymentApprovedAt,
  }) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get role;
  @override
  String? get profilePicture;
  @override
  @JsonKey(name: 'paymentStatus')
  String? get paymentStatus;
  @override
  @JsonKey(name: 'paymentReceipt')
  String? get paymentReceipt;
  @override
  @JsonKey(name: 'paymentApprovedAt')
  DateTime? get paymentApprovedAt;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
