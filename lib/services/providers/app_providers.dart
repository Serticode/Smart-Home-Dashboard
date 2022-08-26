import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:smart_home_dashboard/models/device_model.dart';

class AppProviders {
  //! DB PROVIDER
  //! CONTAINS THE LIST OF USERS DEVICES PER ROOM.

  //! ADD DEVICE
  static Future<bool> addDevice(
      {required String? deviceName,
      required String? deviceType,
      required Uint8List? deviceImageBytes,
      required String? inHouseDeviceLocation,
      required String storageBoxName}) async {
    //! IS DEVICE ADDED
    bool _isDeviceAdded = false;

    //!GET THE DEVICE LIST BOX
    Box<Device> _deviceListBox = Hive.box<Device>(storageBoxName);

    //! ASSIGN RECEIVED VALUES
    final Device _device = Device()
      ..deviceName = deviceName
      ..deviceType = deviceType
      ..isDeviceOn = "false"
      ..inHouseDeviceLocation = inHouseDeviceLocation
      ..deviceImageBytes = deviceImageBytes;

    //! ADD BOX TO LOCATION
    _deviceListBox.add(_device);

    //! CHECK IF DEVICE IS IN DEVICE BOX LIST
    _isDeviceAdded = _deviceListBox.values.any((element) =>
        element.deviceName == deviceName &&
        element.deviceType == deviceType &&
        element.inHouseDeviceLocation == inHouseDeviceLocation);

    return _isDeviceAdded;
  }

  //! UPDATE DEVICE
  static bool updateDevice(
      {required Device theDevice,
      required String? deviceName,
      required String? deviceType,
      required String? isDeviceOn,
      required String? inHouseDeviceLocation,
      required Uint8List? deviceImageBytes}) {
    //! IS DEVICE UPDATED
    bool _isDeviceUpdated = false;

    //! UPDATE DEVICE DETAILS
    //! CHECK IF THEY ARE NULL, IF THEY ARE, ASSIGN THE PREVIOUS DETAIL.
    theDevice.deviceName = deviceName ?? theDevice.deviceName;
    theDevice.deviceType = deviceType ?? theDevice.deviceType;
    theDevice.inHouseDeviceLocation =
        inHouseDeviceLocation ?? theDevice.inHouseDeviceLocation;
    theDevice.isDeviceOn = isDeviceOn ?? theDevice.isDeviceOn;
    theDevice.deviceImageBytes = deviceImageBytes ?? theDevice.deviceImageBytes;

    _isDeviceUpdated = true;
    theDevice.save();

    return _isDeviceUpdated;
  }

  //! REMOVE DEVICE
  static Future<bool> removeDevice({
    required Device theDevice,
  }) async {
    //! IS DEVICE REMOVED
    bool _isDeviceRemoved = false;

    theDevice.delete();
    _isDeviceRemoved = true;

    return _isDeviceRemoved;
  }

  //! ROOM PROVIDER
  //! CONTAINS THE LIST OF USERS DEVICES PER ROOM.

  //! ADD ROOM
  static Future<bool> addRoom(
      {required String roomName,
      required String roomIconName,
      required String storageBoxName}) async {
    //! IS ROOM ADDED
    bool _isRoomAdded = false;

    //! GET THE DEVICE LIST BOX
    //! REMOVE SPECIFIC DEVICE
    Box _roomListBox = Hive.box<Device>(storageBoxName);

    //! STORE THE VALUES
    _roomListBox.putAll({
      roomName: {"roomName": roomName, "roomIcon": roomIconName}
    });

    return _isRoomAdded;
  }
}
