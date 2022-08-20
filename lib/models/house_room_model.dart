import 'package:flutter/material.dart';

class HouseRoomModel {
  //! LIST OF ROOMS
  static const List<Map<String, dynamic>> listOfRooms = [
    {"roomName": "Living room", "roomIcon": Icons.living_outlined},
    {"roomName": "Bedroom", "roomIcon": Icons.bed_outlined},
    {"roomName": "Kitchen", "roomIcon": Icons.kitchen_outlined},
    {"roomName": "Dining", "roomIcon": Icons.dining_outlined},
    {"roomName": "Lounge", "roomIcon": Icons.weekend_outlined}
  ];

  //! LIST OF DEVICES PER ROOM
  //! LIVING ROOM
  static List<Map<String, dynamic>> listOfDevicesInLivingRoom = [
    {
      "deviceImage": AssetImage("assets/abbey.jpg"),
      "deviceDetails": {
        "deviceId": "1",
        "deviceName": "JBL Surround Sound",
        "deviceType": "Speaker",
        "inHouseDeviceLocation": "Bedroom",
        "isDeviceOn": "false"
      }
    },
    {
      "deviceImage": AssetImage("assets/bedroom.jpg"),
      "deviceDetails": {
        "deviceId": "2",
        "deviceName": "Samsung Smart TV",
        "deviceType": "Television",
        "inHouseDeviceLocation": "Living room",
        "isDeviceOn": "false"
      }
    },
    {
      "deviceImage": AssetImage("assets/dining.jpg"),
      "deviceDetails": {
        "deviceId": "3",
        "deviceName": "LG Freezer",
        "deviceType": "Freezer",
        "inHouseDeviceLocation": "Kitchen",
        "isDeviceOn": "false"
      }
    },
    {
      "deviceImage": AssetImage("assets/living_room.jpg"),
      "deviceDetails": {
        "deviceId": "4",
        "deviceName": "Serticode Home Alarm",
        "deviceType": "Alarm System",
        "inHouseDeviceLocation": "Walk way",
        "isDeviceOn": "false"
      }
    },
    {
      "deviceImage": AssetImage("assets/lounge.jpg"),
      "deviceDetails": {
        "deviceId": "5",
        "deviceName": "Apple Vacuum Cleaner",
        "deviceType": "Vacuum Cleaner",
        "inHouseDeviceLocation": "Storage",
        "isDeviceOn": "false"
      }
    },
  ];

  //! BEDROOM
  static List<Map<String, dynamic>> listOfDevicesInBedroom = [];

  //! KITCHEN
  static List<Map<String, dynamic>> listOfDevicesInKitchen = [
    {
      "deviceImage": AssetImage("assets/abbey.jpg"),
      "deviceDetails": {
        "deviceId": "1",
        "deviceName": "JBL Surround Sound",
        "deviceType": "Speaker",
        "inHouseDeviceLocation": "Bedroom",
        "isDeviceOn": "false"
      }
    }
  ];

  //! DINING
  static List<Map<String, dynamic>> listOfDevicesInDinning = [];

  //! LOUNGE
  static List<Map<String, dynamic>> listOfDevicesInLounge = [
    {
      "deviceImage": AssetImage("assets/abbey.jpg"),
      "deviceDetails": {
        "deviceId": "1",
        "deviceName": "JBL Surround Sound",
        "deviceType": "Speaker",
        "inHouseDeviceLocation": "Bedroom",
        "isDeviceOn": "false"
      }
    }
  ];
}
