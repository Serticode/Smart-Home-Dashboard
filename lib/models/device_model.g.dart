// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceModelAdapter extends TypeAdapter<DeviceModel> {
  @override
  final int typeId = 1;

  @override
  DeviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceModel(
      deviceName: fields[0] as String?,
      deviceType: fields[1] as String?,
      isDeviceOn: fields[2] as String?,
      inHouseDeviceLocation: fields[4] as String?,
    )..deviceImageBytes = fields[3] as Uint8List?;
  }

  @override
  void write(BinaryWriter writer, DeviceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.deviceName)
      ..writeByte(1)
      ..write(obj.deviceType)
      ..writeByte(2)
      ..write(obj.isDeviceOn)
      ..writeByte(3)
      ..write(obj.deviceImageBytes)
      ..writeByte(4)
      ..write(obj.inHouseDeviceLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
