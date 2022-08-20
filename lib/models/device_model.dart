class DeviceModel {
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? isDeviceOn;
  //Uint8List? deviceImage;
  String? inHouseDeviceLocation;

  DeviceModel(
      {this.deviceId,
      this.deviceName,
      this.deviceType,
      this.isDeviceOn,
      this.inHouseDeviceLocation});

  DeviceModel.fromMap(Map<String, dynamic> map) {
    deviceId = map['deviceId'];
    deviceName = map["deviceName"];
    deviceType = map['deviceType'];
    isDeviceOn = map["isDeviceOn"];
    //deviceImage = map["deviceImage"];
    inHouseDeviceLocation = map["inHouseDeviceLocation"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'deviceId': deviceId,
      'deviceName': deviceName,
      'deviceType': deviceType,
      "isDeviceOn": isDeviceOn,
      //'deviceImage': deviceImage,
      'inHouseDeviceLocation': inHouseDeviceLocation,
    };
    return map;
  }
}
