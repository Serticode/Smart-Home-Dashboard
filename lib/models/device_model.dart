import 'dart:typed_data';
import "package:hive/hive.dart";
part "device_model.g.dart";

@HiveType(typeId: 1)
class Device extends HiveObject {
  @HiveField(0)
  late String? deviceName;

  @HiveField(1)
  late String? deviceType;

  @HiveField(2)
  late String? isDeviceOn = "false";

  @HiveField(3)
  late Uint8List? deviceImageBytes;

  @HiveField(4)
  late String? inHouseDeviceLocation;

  Device(
      {this.deviceName,
      this.deviceType,
      this.isDeviceOn,
      this.inHouseDeviceLocation});
}
