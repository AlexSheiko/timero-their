// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) {
  return _UserDetails.fromJson(json);
}

/// @nodoc
mixin _$UserDetails {
  List<String>? get timersOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDetailsCopyWith<UserDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailsCopyWith<$Res> {
  factory $UserDetailsCopyWith(
          UserDetails value, $Res Function(UserDetails) then) =
      _$UserDetailsCopyWithImpl<$Res, UserDetails>;
  @useResult
  $Res call({List<String>? timersOrder});
}

/// @nodoc
class _$UserDetailsCopyWithImpl<$Res, $Val extends UserDetails>
    implements $UserDetailsCopyWith<$Res> {
  _$UserDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timersOrder = freezed,
  }) {
    return _then(_value.copyWith(
      timersOrder: freezed == timersOrder
          ? _value.timersOrder
          : timersOrder // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDetailsCopyWith<$Res>
    implements $UserDetailsCopyWith<$Res> {
  factory _$$_UserDetailsCopyWith(
          _$_UserDetails value, $Res Function(_$_UserDetails) then) =
      __$$_UserDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? timersOrder});
}

/// @nodoc
class __$$_UserDetailsCopyWithImpl<$Res>
    extends _$UserDetailsCopyWithImpl<$Res, _$_UserDetails>
    implements _$$_UserDetailsCopyWith<$Res> {
  __$$_UserDetailsCopyWithImpl(
      _$_UserDetails _value, $Res Function(_$_UserDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timersOrder = freezed,
  }) {
    return _then(_$_UserDetails(
      timersOrder: freezed == timersOrder
          ? _value._timersOrder
          : timersOrder // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDetails implements _UserDetails {
  const _$_UserDetails({required final List<String>? timersOrder})
      : _timersOrder = timersOrder;

  factory _$_UserDetails.fromJson(Map<String, dynamic> json) =>
      _$$_UserDetailsFromJson(json);

  final List<String>? _timersOrder;
  @override
  List<String>? get timersOrder {
    final value = _timersOrder;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserDetails(timersOrder: $timersOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDetails &&
            const DeepCollectionEquality()
                .equals(other._timersOrder, _timersOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_timersOrder));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDetailsCopyWith<_$_UserDetails> get copyWith =>
      __$$_UserDetailsCopyWithImpl<_$_UserDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDetailsToJson(
      this,
    );
  }
}

abstract class _UserDetails implements UserDetails {
  const factory _UserDetails({required final List<String>? timersOrder}) =
      _$_UserDetails;

  factory _UserDetails.fromJson(Map<String, dynamic> json) =
      _$_UserDetails.fromJson;

  @override
  List<String>? get timersOrder;
  @override
  @JsonKey(ignore: true)
  _$$_UserDetailsCopyWith<_$_UserDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
