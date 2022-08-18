import 'dart:typed_data';

class DevicesSpecs {
  String? _deviceId;
  String? deviceName;
  String? deviceType;
  Uint8List? deviceImage;
  String? inHouseDeviceLocation;

  DevicesSpecs(this._deviceId, this.deviceName, this.deviceType,
      this.deviceImage, this.inHouseDeviceLocation);

  DevicesSpecs.fromMap(Map<String, dynamic> map) {
    _deviceId = map['deviceId'];
    deviceName = map["deviceName"];
    deviceType = map['deviceType'];
    deviceImage = map["deviceImage"];
    inHouseDeviceLocation = map["deviceLocation"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'deviceId': _deviceId,
      'deviceName': deviceName,
      'deviceType': deviceType,
      'deviceImage': deviceImage,
      'deviceLocation': inHouseDeviceLocation,
    };
    return map;
  }
}
