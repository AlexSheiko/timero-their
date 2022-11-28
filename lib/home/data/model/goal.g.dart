// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goal _$$_GoalFromJson(Map<String, dynamic> json) => _$_Goal(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      resets: (json['resets'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      goalDays: json['goalDays'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GoalToJson(_$_Goal instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'resets': instance.resets.map((e) => e.toIso8601String()).toList(),
      'goalDays': instance.goalDays,
    };
