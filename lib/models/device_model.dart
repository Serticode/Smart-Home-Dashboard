import 'dart:typed_data';

import "package:hive/hive.dart";
part "device_model.g.dart";

@HiveType(typeId: 1)
class DeviceModel extends HiveObject {
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

  DeviceModel(
      {this.deviceName,
      this.deviceType,
      this.isDeviceOn,
      this.inHouseDeviceLocation});

  DeviceModel.fromMap(Map<dynamic, dynamic> map) {
    deviceName = map["deviceName"];
    deviceType = map['deviceType'];
    isDeviceOn = map["isDeviceOn"];
    deviceImageBytes = map["deviceImageBytes"];
    inHouseDeviceLocation = map["inHouseDeviceLocation"];
  }

  Map<dynamic, dynamic> toMap() {
    var map = <dynamic, dynamic>{
      'deviceName': deviceName,
      'deviceType': deviceType,
      "isDeviceOn": isDeviceOn,
      'deviceImageBytes': deviceImageBytes,
      'inHouseDeviceLocation': inHouseDeviceLocation,
    };
    return map;
  }
}
