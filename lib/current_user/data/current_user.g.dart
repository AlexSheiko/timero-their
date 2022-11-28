// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentUserAdapter extends TypeAdapter<CurrentUser> {
  @override
  final int typeId = 6;

  @override
  CurrentUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentUser(
      id: fields[0] as String,
      email: fields[1] as String,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentUser _$$_CurrentUserFromJson(Map<String, dynamic> json) =>
    _$_CurrentUser(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_CurrentUserToJson(_$_CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };
