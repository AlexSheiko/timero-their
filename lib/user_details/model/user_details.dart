import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details.freezed.dart';
part 'user_details.g.dart';

@freezed
class UserDetails with _$UserDetails {
  const factory UserDetails({
    required List<String>? timersOrder,
  }) = _UserDetails;

  factory UserDetails.fromJson(Map<String, Object?> json) =>
      _$UserDetailsFromJson(json);
}
