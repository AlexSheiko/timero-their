// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDetails _$$_UserDetailsFromJson(Map<String, dynamic> json) =>
    _$_UserDetails(
      timersOrder: (json['timersOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_UserDetailsToJson(_$_UserDetails instance) =>
    <String, dynamic>{
      'timersOrder': instance.timersOrder,
    };
