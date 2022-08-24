import 'dart:developer';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';

class AppProviders {
  //! DB PROVIDER
  //! CONTAINS THE LIST OF USERS DEVICES PER ROOM.

  //! ADD DEVICE
  static Future<bool> addDevice({
    required String? deviceName,
    required String? deviceType,
    required Uint8List? deviceImageBytes,
    required String? inHouseDeviceLocation,
    required String storageBoxName,
  }) async {
    //! IS DEVICE ADDED
    bool _isDeviceAdded = false;

    final DeviceModel _device = DeviceModel()
      ..deviceName = deviceName
      ..deviceType = deviceType
      ..isDeviceOn = "false"
      ..inHouseDeviceLocation = inHouseDeviceLocation
      ..deviceImageBytes = deviceImageBytes;

    //!GET THE DEVICE LIST BOX
    Box<DeviceModel> _deviceListBox = Hive.box<DeviceModel>(storageBoxName);

    //! ADD BOX TO LOCATION
    _deviceListBox.add(_device);

    _isDeviceAdded = _deviceListBox.values.any((element) =>
        element.deviceName == deviceName &&
        element.deviceType == deviceType &&
        element.inHouseDeviceLocation == inHouseDeviceLocation);

    return _isDeviceAdded;
  }

  //! UPDATE DEVICE
  static bool updateDevice(
      {required DeviceModel theDevice,
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

  //! FETCH USER DEVICES LIST
  static Future<bool> fetchUserDevicesList(
      {required String storageBoxName}) async {
    log("Started - Fetch User Devices List");
    //! IS LIST FETCH COMPLETED
    bool isListFetchCompleted = false;

    //! GET THE DEVICE LIST BOX
    Box _deviceListBox = Hive.box<DeviceModel>(storageBoxName);

    //! CAST TYPES FOR ITERATION
    Iterable<DeviceModel> _deviceList =
        _deviceListBox.values.cast<DeviceModel>();

    //! ADD DEVICES TO LISTS
    _deviceList.forEach((device) {
      switch (device.inHouseDeviceLocation) {
        case "Bedroom":
          HouseRoomModel.listOfDevicesInBedroom.add(device);
          log("Device added into: Bedroom");
          break;
        case "Living room":
          HouseRoomModel.listOfDevicesInLivingRoom.add(device);
          log("Device added into: Living room");
          break;
        case "Kitchen":
          HouseRoomModel.listOfDevicesInKitchen.add(device);
          log("Device added into: Kitchen");
          break;
        case "Dining":
          HouseRoomModel.listOfDevicesInDining.add(device);
          log("Device added into: Dining");
          break;
        case "Lounge":
          HouseRoomModel.listOfDevicesInLounge.add(device);
          log("Device added into: Lounge");

          break;
        default:
      }
    });

    log("Ended - Fetch User Devices");

    return isListFetchCompleted;
  }

  //! REMOVE DEVICE
  static Future<bool> removeDevice({
    required DeviceModel theDevice,
  }) async {
    //! IS DEVICE REMOVED
    bool _isDeviceRemoved = false;

    theDevice.delete();
    _isDeviceRemoved = true;

    return _isDeviceRemoved;
  }

  //! ROOM PROVIDER
  //! CONTAINS THE LIST OF USERS DEVICES PER ROOM.
  static Future<Box> openRoomsListBox(
          {required String userEmail, required String userName}) async =>
      await Hive.openBox("${userEmail}_${userName}_listOfRooms");

  //! ADD ROOM
  static Future<bool> addRoom(
      {required String roomName,
      required String roomIconName,
      required String storageBoxName}) async {
    //! IS ROOM ADDED
    bool _isRoomAdded = false;

    //! GET THE DEVICE LIST BOX
    //! REMOVE SPECIFIC DEVICE
    Box _roomListBox = Hive.box<DeviceModel>(storageBoxName);

    //! STORE THE VALUES
    _roomListBox.putAll({
      roomName: {"roomName": roomName, "roomIcon": roomIconName}
    });

    return _isRoomAdded;
  }
}
