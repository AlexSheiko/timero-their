// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  List<DateTime> get resets => throw _privateConstructorUsedError;
  int get goalDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime startDate,
      List<DateTime> resets,
      int goalDays});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? startDate = null,
    Object? resets = null,
    Object? goalDays = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resets: null == resets
          ? _value.resets
          : resets // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      goalDays: null == goalDays
          ? _value.goalDays
          : goalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$_GoalCopyWith(_$_Goal value, $Res Function(_$_Goal) then) =
      __$$_GoalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime startDate,
      List<DateTime> resets,
      int goalDays});
}

/// @nodoc
class __$$_GoalCopyWithImpl<$Res> extends _$GoalCopyWithImpl<$Res, _$_Goal>
    implements _$$_GoalCopyWith<$Res> {
  __$$_GoalCopyWithImpl(_$_Goal _value, $Res Function(_$_Goal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? startDate = null,
    Object? resets = null,
    Object? goalDays = null,
  }) {
    return _then(_$_Goal(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resets: null == resets
          ? _value._resets
          : resets // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      goalDays: null == goalDays
          ? _value.goalDays
          : goalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Goal implements _Goal {
  const _$_Goal(
      {required this.id,
      required this.userId,
      required this.name,
      required this.startDate,
      final List<DateTime> resets = const [],
      this.goalDays = 0})
      : _resets = resets;

  factory _$_Goal.fromJson(Map<String, dynamic> json) => _$$_GoalFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final DateTime startDate;
  final List<DateTime> _resets;
  @override
  @JsonKey()
  List<DateTime> get resets {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resets);
  }

  @override
  @JsonKey()
  final int goalDays;

  @override
  String toString() {
    return 'Goal(id: $id, userId: $userId, name: $name, startDate: $startDate, resets: $resets, goalDays: $goalDays)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Goal &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality().equals(other._resets, _resets) &&
            (identical(other.goalDays, goalDays) ||
                other.goalDays == goalDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, startDate,
      const DeepCollectionEquality().hash(_resets), goalDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoalCopyWith<_$_Goal> get copyWith =>
      __$$_GoalCopyWithImpl<_$_Goal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoalToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {required final String id,
      required final String userId,
      required final String name,
      required final DateTime startDate,
      final List<DateTime> resets,
      final int goalDays}) = _$_Goal;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$_Goal.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  DateTime get startDate;
  @override
  List<DateTime> get resets;
  @override
  int get goalDays;
  @override
  @JsonKey(ignore: true)
  _$$_GoalCopyWith<_$_Goal> get copyWith => throw _privateConstructorUsedError;
}
