import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class Lounge extends StatefulWidget {
  const Lounge({Key? key}) : super(key: key);

  @override
  State<Lounge> createState() => _LoungeState();
}

class _LoungeState extends State<Lounge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HouseRoomModel.listOfDevicesInLounge.isEmpty
          ? Center(child: Text("You haven't added any device to this room."))
          : MasonryGridView.count(
              itemCount: HouseRoomModel.listOfDevicesInLounge.length,
              crossAxisCount: 2,
              mainAxisSpacing: 21,
              itemBuilder: (context, index) => Card(
                    elevation: 12.0,
                    color: AppThemeColours.tertiaryColour.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                            width: 1.5, color: AppThemeColours.primaryColour)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                                  .listOfDevicesInLounge[index]
                                              ["deviceImage"],
                                          fit: BoxFit.cover))),

                              //! SWITCH
                              SwitchListTile.adaptive(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  activeColor: AppThemeColours.primaryColour,
                                  title: Text(DeviceModel.fromMap(HouseRoomModel
                                                      .listOfDevicesInLounge[
                                                  index]["deviceDetails"])
                                              .isDeviceOn ==
                                          true.toString()
                                      ? "On"
                                      : "Off"),
                                  value: DeviceModel.fromMap(HouseRoomModel
                                                      .listOfDevicesInLounge[
                                                  index]["deviceDetails"])
                                              .isDeviceOn ==
                                          "true"
                                      ? true
                                      : false,
                                  onChanged: (value) => setState(() {
                                        DeviceModel.fromMap(HouseRoomModel
                                                    .listOfDevicesInLounge[
                                                index]["deviceDetails"])
                                            .isDeviceOn = value.toString();
                                      })),
                            ]),
                          ),

                          //! BOTTOM
                          Container(
                            width: double.infinity,
                            color: AppThemeColours.primaryColour,
                            padding: AppScreenUtils.deviceCardPadding,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE NAME
                                  Text(
                                      DeviceModel.fromMap(HouseRoomModel
                                                  .listOfDevicesInLounge[index]
                                              ["deviceDetails"])
                                          .deviceName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.white)),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE LOCATION
                                  Text(
                                      "Location: ${DeviceModel.fromMap(HouseRoomModel.listOfDevicesInLounge[index]["deviceDetails"]).inHouseDeviceLocation!}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.white)),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,
                                ]),
                          ),
                        ]),
                  )),
    );
  }
}
