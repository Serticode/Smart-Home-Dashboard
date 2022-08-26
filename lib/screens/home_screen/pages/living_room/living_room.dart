import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/services/providers/app_providers.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  late Box _livingRoomDevices;
  double _sliderValue = 10.0;

  @override
  void initState() {
    _livingRoomDevices = Hive.box<Device>("Living room");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _livingRoomDevices.listenable(),
        builder: (context, value, child) => _livingRoomDevices.isEmpty
            ? Center(child: Text("You haven't added any device to this room."))
            : MasonryGridView.count(
                itemCount: _livingRoomDevices.length,
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
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: _livingRoomDevices.values
                                                .elementAt(index)
                                                .deviceImageBytes ==
                                            null
                                        ? Center(child: Text("No image Added"))
                                        : Image.memory(
                                            _livingRoomDevices.values
                                                .elementAt(index)
                                                .deviceImageBytes,
                                            fit: BoxFit.cover)),
                              ),

                              //! SWITCH
                              SwitchListTile.adaptive(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  activeColor: AppThemeColours.primaryColour,
                                  title: Text(_livingRoomDevices.values
                                              .elementAt(index)
                                              .isDeviceOn ==
                                          true.toString()
                                      ? "On"
                                      : "Off"),
                                  value: _livingRoomDevices.values
                                              .elementAt(index)
                                              .isDeviceOn ==
                                          "true"
                                      ? true
                                      : false,
                                  onChanged: (value) => setState(() {
                                        _livingRoomDevices.values
                                            .elementAt(index)
                                            .isDeviceOn = value.toString();

                                        value
                                            ? AppFunctionalUtils.showAppSnackBar(
                                                theBuildContext: context,
                                                message:
                                                    "${_livingRoomDevices.values.elementAt(index).deviceName} turned ON!")
                                            : AppFunctionalUtils.showAppSnackBar(
                                                theBuildContext: context,
                                                message:
                                                    "${_livingRoomDevices.values.elementAt(index).deviceName} turned OFF!");
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! DEVICE NAME
                                        Text(_livingRoomDevices.values
                                            .elementAt(index)
                                            .deviceName!),

                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! DEVICE NAME
                                        Text(_livingRoomDevices.values
                                            .elementAt(index)
                                            .deviceType!),

                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! DEVICE LOCATION
                                        Text(_livingRoomDevices.values
                                            .elementAt(index)
                                            .inHouseDeviceLocation),

                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall
                                      ]),
                                  Column(children: [
                                    //! SPACER
                                    AppScreenUtils.verticalSpaceSmall,

                                    InkWell(
                                        onTap: () => AppFunctionalUtils
                                            .showAppModalBottomSheet(
                                                theBuildContext: context,
                                                child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding: AppScreenUtils
                                                            .cardPadding,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              //! CLOSE BUTTON
                                                              //! CLOSE BUTTON &&  HEADER
                                                              Row(children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () =>
                                                                            //! CLOSE NAVIGATOR
                                                                            Navigator.of(context)
                                                                                .pop(),
                                                                    icon: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: AppThemeColours
                                                                            .primaryColour)),

                                                                //! SPACER
                                                                AppScreenUtils
                                                                    .horizontalSpaceMedium,

                                                                //! HEADER
                                                                Text(
                                                                    "Control ${_livingRoomDevices.values.elementAt(index).deviceName!} ",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                12.0,
                                                                            fontWeight:
                                                                                FontWeight.w500))
                                                              ]),

                                                              //! SPACER
                                                              AppScreenUtils
                                                                  .verticalSpaceSmall,

                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    //! ICON
                                                                    Icon(
                                                                        Icons
                                                                            .speaker_outlined,
                                                                        color: AppThemeColours
                                                                            .primaryColour),

                                                                    //! SPACER
                                                                    AppScreenUtils
                                                                        .horizontalSpaceMedium,

                                                                    //! SLIDER
                                                                    StatefulBuilder(builder:
                                                                        (context,
                                                                            state) {
                                                                      return Slider(
                                                                          min:
                                                                              1.0,
                                                                          max:
                                                                              100,
                                                                          divisions:
                                                                              10,
                                                                          value:
                                                                              _sliderValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            state(() {
                                                                              _sliderValue = value;
                                                                            });

                                                                            setState(() {});
                                                                          });
                                                                    })
                                                                  ])
                                                            ])))),
                                        child: Icon(Icons.devices_outlined,
                                            color:
                                                AppThemeColours.primaryColour)),

                                    //! SPACER
                                    AppScreenUtils.verticalSpaceSmall,

                                    InkWell(
                                      onTap: () => AppProviders.removeDevice(
                                          theDevice: _livingRoomDevices.values
                                              .elementAt(index)),
                                      child: Icon(Icons.delete_outlined,
                                          color: Colors.red.shade900),
                                    ),

                                    //! SPACER
                                    AppScreenUtils.verticalSpaceSmall
                                  ])
                                ],
                              ))
                        ]))));
  }
}
