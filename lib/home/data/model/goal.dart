import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String userId,
    required String name,
    required DateTime startDate,
    @Default([]) List<DateTime> resets,
    @Default(0) int goalDays,
  }) = _Goal;

  factory Goal.fromJson(Map<String, Object?> json) => _$GoalFromJson(json);

  static Goal fromMap(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      resets: _resetsFromMap(json['resets']),
      goalDays: _goalDays(json['goalDays']),
    );
  }

  static Map<String, dynamic> toMap(Goal goal) {
    return {
      'id': goal.id,
      'userId': goal.userId,
      'name': goal.name,
      'startDate': goal.startDate.toIso8601String(),
      'resets': _resetsToMap(goal.resets),
      'goalDays': goal.goalDays,
    };
  }

  static List<DateTime> _resetsFromMap(String string) {
    List<DateTime> resets = [];
    final split = string.split('A');
    if (split.first.isNotEmpty) {
      for (var element in split) {
        if (element.isNotEmpty) {
          resets.add(DateTime.parse(element));
        }
      }
    }
    // Show the most recent resets first
    resets.sort((a, b) => b.compareTo(a));
    return resets;
  }

  static _resetsToMap(List<DateTime> resets) {
    String result = '';
    if (resets.isNotEmpty) {
      for (var element in resets) {
        result += '${element.toIso8601String()}A';
      }
    }
    return result;
  }

  static int _goalDays(dynamic json) {
    int result = 0;
    if (json is int) {
      result = json;
    } else if (json.isNotEmpty) {
      result = int.parse(json.toString());
    }
    return result;
  }
}
