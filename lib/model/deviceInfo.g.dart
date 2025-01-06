// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceInfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceInfoDataAdapter extends TypeAdapter<DeviceInfoData> {
  @override
  final int typeId = 1;

  @override
  DeviceInfoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceInfoData(
      model: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceInfoData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
