// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AnnouncementModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedBy')
  PostedByModel get postedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnouncementModelCopyWith<AnnouncementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementModelCopyWith<$Res> {
  factory $AnnouncementModelCopyWith(
    AnnouncementModel value,
    $Res Function(AnnouncementModel) then,
  ) = _$AnnouncementModelCopyWithImpl<$Res, AnnouncementModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String title,
    String description,
    DateTime date,
    String location,
    String? image,
    @JsonKey(name: 'postedBy') PostedByModel postedBy,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'updatedAt') DateTime updatedAt,
  });

  $PostedByModelCopyWith<$Res> get postedBy;
}

/// @nodoc
class _$AnnouncementModelCopyWithImpl<$Res, $Val extends AnnouncementModel>
    implements $AnnouncementModelCopyWith<$Res> {
  _$AnnouncementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? location = null,
    Object? image = freezed,
    Object? postedBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String,
            image:
                freezed == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String?,
            postedBy:
                null == postedBy
                    ? _value.postedBy
                    : postedBy // ignore: cast_nullable_to_non_nullable
                        as PostedByModel,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostedByModelCopyWith<$Res> get postedBy {
    return $PostedByModelCopyWith<$Res>(_value.postedBy, (value) {
      return _then(_value.copyWith(postedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnnouncementModelImplCopyWith<$Res>
    implements $AnnouncementModelCopyWith<$Res> {
  factory _$$AnnouncementModelImplCopyWith(
    _$AnnouncementModelImpl value,
    $Res Function(_$AnnouncementModelImpl) then,
  ) = __$$AnnouncementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String title,
    String description,
    DateTime date,
    String location,
    String? image,
    @JsonKey(name: 'postedBy') PostedByModel postedBy,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'updatedAt') DateTime updatedAt,
  });

  @override
  $PostedByModelCopyWith<$Res> get postedBy;
}

/// @nodoc
class __$$AnnouncementModelImplCopyWithImpl<$Res>
    extends _$AnnouncementModelCopyWithImpl<$Res, _$AnnouncementModelImpl>
    implements _$$AnnouncementModelImplCopyWith<$Res> {
  __$$AnnouncementModelImplCopyWithImpl(
    _$AnnouncementModelImpl _value,
    $Res Function(_$AnnouncementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? location = null,
    Object? image = freezed,
    Object? postedBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AnnouncementModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String,
        image:
            freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String?,
        postedBy:
            null == postedBy
                ? _value.postedBy
                : postedBy // ignore: cast_nullable_to_non_nullable
                    as PostedByModel,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AnnouncementModelImpl implements _AnnouncementModel {
  const _$AnnouncementModelImpl({
    @JsonKey(name: '_id') required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.image,
    @JsonKey(name: 'postedBy') required this.postedBy,
    @JsonKey(name: 'createdAt') required this.createdAt,
    @JsonKey(name: 'updatedAt') required this.updatedAt,
  });

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final String location;
  @override
  final String? image;
  @override
  @JsonKey(name: 'postedBy')
  final PostedByModel postedBy;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AnnouncementModel(id: $id, title: $title, description: $description, date: $date, location: $location, image: $image, postedBy: $postedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnouncementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.postedBy, postedBy) ||
                other.postedBy == postedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    date,
    location,
    image,
    postedBy,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnouncementModelImplCopyWith<_$AnnouncementModelImpl> get copyWith =>
      __$$AnnouncementModelImplCopyWithImpl<_$AnnouncementModelImpl>(
        this,
        _$identity,
      );
}

abstract class _AnnouncementModel implements AnnouncementModel {
  const factory _AnnouncementModel({
    @JsonKey(name: '_id') required final String id,
    required final String title,
    required final String description,
    required final DateTime date,
    required final String location,
    final String? image,
    @JsonKey(name: 'postedBy') required final PostedByModel postedBy,
    @JsonKey(name: 'createdAt') required final DateTime createdAt,
    @JsonKey(name: 'updatedAt') required final DateTime updatedAt,
  }) = _$AnnouncementModelImpl;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get date;
  @override
  String get location;
  @override
  String? get image;
  @override
  @JsonKey(name: 'postedBy')
  PostedByModel get postedBy;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnouncementModelImplCopyWith<_$AnnouncementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostedByModel _$PostedByModelFromJson(Map<String, dynamic> json) {
  return _PostedByModel.fromJson(json);
}

/// @nodoc
mixin _$PostedByModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PostedByModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostedByModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostedByModelCopyWith<PostedByModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostedByModelCopyWith<$Res> {
  factory $PostedByModelCopyWith(
    PostedByModel value,
    $Res Function(PostedByModel) then,
  ) = _$PostedByModelCopyWithImpl<$Res, PostedByModel>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class _$PostedByModelCopyWithImpl<$Res, $Val extends PostedByModel>
    implements $PostedByModelCopyWith<$Res> {
  _$PostedByModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostedByModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostedByModelImplCopyWith<$Res>
    implements $PostedByModelCopyWith<$Res> {
  factory _$$PostedByModelImplCopyWith(
    _$PostedByModelImpl value,
    $Res Function(_$PostedByModelImpl) then,
  ) = __$$PostedByModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class __$$PostedByModelImplCopyWithImpl<$Res>
    extends _$PostedByModelCopyWithImpl<$Res, _$PostedByModelImpl>
    implements _$$PostedByModelImplCopyWith<$Res> {
  __$$PostedByModelImplCopyWithImpl(
    _$PostedByModelImpl _value,
    $Res Function(_$PostedByModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostedByModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$PostedByModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostedByModelImpl implements _PostedByModel {
  const _$PostedByModelImpl({
    @JsonKey(name: '_id') required this.id,
    required this.name,
  });

  factory _$PostedByModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostedByModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'PostedByModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostedByModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of PostedByModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostedByModelImplCopyWith<_$PostedByModelImpl> get copyWith =>
      __$$PostedByModelImplCopyWithImpl<_$PostedByModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostedByModelImplToJson(this);
  }
}

abstract class _PostedByModel implements PostedByModel {
  const factory _PostedByModel({
    @JsonKey(name: '_id') required final String id,
    required final String name,
  }) = _$PostedByModelImpl;

  factory _PostedByModel.fromJson(Map<String, dynamic> json) =
      _$PostedByModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;

  /// Create a copy of PostedByModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostedByModelImplCopyWith<_$PostedByModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
