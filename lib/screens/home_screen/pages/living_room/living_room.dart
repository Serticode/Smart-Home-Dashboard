import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        itemCount: HouseRoomModel.listOfDevicesInLivingRoom.length,
        crossAxisCount: 2,
        mainAxisSpacing: 21,
        itemBuilder: (context, index) => Card(
            elevation: 12.0,
            color: AppThemeColours.tertiaryColour.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                    width: 1.5, color: AppThemeColours.primaryColour)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //! SPACER
              AppScreenUtils.verticalSpaceTiny,

              Container(
                padding: AppScreenUtils.deviceCardPadding,
                child: Column(children: [
                  Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                              image: HouseRoomModel
                                      .listOfDevicesInLivingRoom[index]
                                  ["deviceImage"],
                              fit: BoxFit.cover))),

                  //! SWITCH
                  SwitchListTile.adaptive(
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: AppThemeColours.primaryColour,
                      title: Text(DeviceModel.fromMap(HouseRoomModel
                                          .listOfDevicesInLivingRoom[index]
                                      ["deviceDetails"])
                                  .isDeviceOn ==
                              true.toString()
                          ? "On"
                          : "Off"),
                      value: DeviceModel.fromMap(HouseRoomModel
                                          .listOfDevicesInLivingRoom[index]
                                      ["deviceDetails"])
                                  .isDeviceOn ==
                              "true"
                          ? true
                          : false,
                      onChanged: (value) => setState(() {
                            DeviceModel.fromMap(HouseRoomModel
                                        .listOfDevicesInLivingRoom[index]
                                    ["deviceDetails"])
                                .isDeviceOn = value.toString();
                          })),
                ]),
              ),

              //! BOTTOM
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFBCC1C2),
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: AppScreenUtils.deviceCardPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! SPACER
                        AppScreenUtils.verticalSpaceSmall,

                        //! DEVICE NAME
                        Text(DeviceModel.fromMap(
                                HouseRoomModel.listOfDevicesInLivingRoom[index]
                                    ["deviceDetails"])
                            .deviceName!),

                        //! SPACER
                        AppScreenUtils.verticalSpaceSmall,

                        //! DEVICE LOCATION
                        Text(
                            "Location: ${DeviceModel.fromMap(HouseRoomModel.listOfDevicesInLivingRoom[index]["deviceDetails"]).inHouseDeviceLocation!}"),

                        //! SPACER
                        AppScreenUtils.verticalSpaceSmall
                      ]))
            ])));
  }
}
