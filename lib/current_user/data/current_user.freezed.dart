// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'current_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return _CurrentUser.fromJson(json);
}

/// @nodoc
mixin _$CurrentUser {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get email => throw _privateConstructorUsedError;
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentUserCopyWith<CurrentUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentUserCopyWith<$Res> {
  factory $CurrentUserCopyWith(
          CurrentUser value, $Res Function(CurrentUser) then) =
      _$CurrentUserCopyWithImpl<$Res, CurrentUser>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String name});
}

/// @nodoc
class _$CurrentUserCopyWithImpl<$Res, $Val extends CurrentUser>
    implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrentUserCopyWith<$Res>
    implements $CurrentUserCopyWith<$Res> {
  factory _$$_CurrentUserCopyWith(
          _$_CurrentUser value, $Res Function(_$_CurrentUser) then) =
      __$$_CurrentUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String name});
}

/// @nodoc
class __$$_CurrentUserCopyWithImpl<$Res>
    extends _$CurrentUserCopyWithImpl<$Res, _$_CurrentUser>
    implements _$$_CurrentUserCopyWith<$Res> {
  __$$_CurrentUserCopyWithImpl(
      _$_CurrentUser _value, $Res Function(_$_CurrentUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
  }) {
    return _then(_$_CurrentUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrentUser implements _CurrentUser {
  const _$_CurrentUser(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.email,
      @HiveField(2) required this.name});

  factory _$_CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$$_CurrentUserFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String email;
  @override
  @HiveField(2)
  final String name;

  @override
  String toString() {
    return 'CurrentUser(id: $id, email: $email, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrentUserCopyWith<_$_CurrentUser> get copyWith =>
      __$$_CurrentUserCopyWithImpl<_$_CurrentUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrentUserToJson(
      this,
    );
  }
}

abstract class _CurrentUser implements CurrentUser {
  const factory _CurrentUser(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String email,
      @HiveField(2) required final String name}) = _$_CurrentUser;

  factory _CurrentUser.fromJson(Map<String, dynamic> json) =
      _$_CurrentUser.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get email;
  @override
  @HiveField(2)
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentUserCopyWith<_$_CurrentUser> get copyWith =>
      throw _privateConstructorUsedError;
}
