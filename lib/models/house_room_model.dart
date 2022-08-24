import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/models/device_model.dart';

class HouseRoomModel {
  //! LIST OF ROOMS
  static const List<Map<String, dynamic>> listOfRooms = [
    {
      "roomName": "Living room",
      "customRoomName": "",
      "roomIcon": Icons.living_outlined
    },
    {
      "roomName": "Bedroom",
      "customRoomName": "",
      "roomIcon": Icons.bed_outlined
    },
    {
      "roomName": "Kitchen",
      "customRoomName": "",
      "roomIcon": Icons.kitchen_outlined
    },
    {
      "roomName": "Dining",
      "customRoomName": "",
      "roomIcon": Icons.dining_outlined
    },
    {
      "roomName": "Lounge",
      "customRoomName": "",
      "roomIcon": Icons.weekend_outlined
    }
  ];

  //! LIST OF DEVICES PER ROOM
  //! LIVING ROOM
  static List<DeviceModel> listOfDevicesInLivingRoom = [
    /* {
      "deviceImage": AssetImage("assets/abbey.jpg"),
      "deviceDetails": {
        "deviceId": "1",
        "deviceName": "JBL Surround Sound",
        "deviceType": "Speaker",
        "inHouseDeviceLocation": "Bedroom",
        "isDeviceOn": "false"
      }
    },*/
  ];

  //! BEDROOM
  static List<DeviceModel> listOfDevicesInBedroom = [];

  //! KITCHEN
  static List<DeviceModel> listOfDevicesInKitchen = [];

  //! DINING
  static List<DeviceModel> listOfDevicesInDining = [];

  //! LOUNGE
  static List<DeviceModel> listOfDevicesInLounge = [];
}
