import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'current_user.g.dart';
part 'current_user.freezed.dart';

@freezed
@HiveType(typeId: 6)
class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String name,
  }) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, Object?> json) =>
      _$CurrentUserFromJson(json);

  factory CurrentUser.loggedOut() =>
      const CurrentUser(id: '', email: '', name: '');

  factory CurrentUser.mocked() => const CurrentUser(
        id: 'Mocked id',
        email: 'email@example.com',
        name: 'Mocked Name',
      );
}
