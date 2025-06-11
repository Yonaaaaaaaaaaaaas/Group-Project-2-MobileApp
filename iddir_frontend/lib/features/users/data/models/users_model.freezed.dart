// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) {
  return _UsersModel.fromJson(json);
}

/// @nodoc
mixin _$UsersModel {
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
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UsersModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsersModelCopyWith<UsersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersModelCopyWith<$Res> {
  factory $UsersModelCopyWith(
    UsersModel value,
    $Res Function(UsersModel) then,
  ) = _$UsersModelCopyWithImpl<$Res, UsersModel>;
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
    @JsonKey(name: 'createdAt') DateTime createdAt,
  });
}

/// @nodoc
class _$UsersModelCopyWithImpl<$Res, $Val extends UsersModel>
    implements $UsersModelCopyWith<$Res> {
  _$UsersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersModel
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
    Object? createdAt = null,
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
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsersModelImplCopyWith<$Res>
    implements $UsersModelCopyWith<$Res> {
  factory _$$UsersModelImplCopyWith(
    _$UsersModelImpl value,
    $Res Function(_$UsersModelImpl) then,
  ) = __$$UsersModelImplCopyWithImpl<$Res>;
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
    @JsonKey(name: 'createdAt') DateTime createdAt,
  });
}

/// @nodoc
class __$$UsersModelImplCopyWithImpl<$Res>
    extends _$UsersModelCopyWithImpl<$Res, _$UsersModelImpl>
    implements _$$UsersModelImplCopyWith<$Res> {
  __$$UsersModelImplCopyWithImpl(
    _$UsersModelImpl _value,
    $Res Function(_$UsersModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsersModel
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
    Object? createdAt = null,
  }) {
    return _then(
      _$UsersModelImpl(
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
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsersModelImpl implements _UsersModel {
  const _$UsersModelImpl({
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
    @JsonKey(name: 'createdAt') required this.createdAt,
  });

  factory _$UsersModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsersModelImplFromJson(json);

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
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'UsersModel(id: $id, name: $name, email: $email, address: $address, phone: $phone, role: $role, profilePicture: $profilePicture, paymentStatus: $paymentStatus, paymentReceipt: $paymentReceipt, paymentApprovedAt: $paymentApprovedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersModelImpl &&
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
    address,
    phone,
    role,
    profilePicture,
    paymentStatus,
    paymentReceipt,
    paymentApprovedAt,
    createdAt,
  );

  /// Create a copy of UsersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersModelImplCopyWith<_$UsersModelImpl> get copyWith =>
      __$$UsersModelImplCopyWithImpl<_$UsersModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsersModelImplToJson(this);
  }
}

abstract class _UsersModel implements UsersModel {
  const factory _UsersModel({
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
    @JsonKey(name: 'createdAt') required final DateTime createdAt,
  }) = _$UsersModelImpl;

  factory _UsersModel.fromJson(Map<String, dynamic> json) =
      _$UsersModelImpl.fromJson;

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
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;

  /// Create a copy of UsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersModelImplCopyWith<_$UsersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
