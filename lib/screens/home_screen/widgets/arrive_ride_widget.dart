import 'dart:developer' as dev;
import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../main.dart';
import '../../../model/GoogleMapSearchModel.dart';
import '../../../model/LocationModel.dart';
import '../../../model/ServiceModel.dart';
import '../../../model/wash_type/datum.dart';
import '../../../network/RestApis.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Extensions/app_common.dart';
import '../../NewEstimateRideListWidget.dart';

class ArriveRiderWidget extends StatefulWidget {
  final String title;
  final TextEditingController destinationLocation;
  ArriveRiderWidget({required this.title, required this.destinationLocation});

  @override
  ArriveRiderWidgetState createState() => ArriveRiderWidgetState();
}

class ArriveRiderWidgetState extends State<ArriveRiderWidget> {
  TextEditingController sourceLocation = TextEditingController();
  // TextEditingController destinationLocation =
  //     TextEditingController(text: appStore.selectedStartAddress);

  FocusNode sourceFocus = FocusNode();
  FocusNode desFocus = FocusNode();

  int selectedIndex = -1;
  String mLocation = "";
  bool isDone = true;
  bool isPickup = true;
  bool isDrop = false;
  double? totalAmount;
  double? subTotal;
  double? amount;

  LocationModel? model;
  ServiceList? serviceList;

  List<WashTypeService> list = [];
  List<Prediction> listAddress = [];

  @override
  void initState() {
    dev.log(widget.title.toString());
    super.initState();
    init();
  }

  void init() async {
    sourceLocation.text = widget.title;
    await getWashServices().then((value) {
      list.addAll(value.data!);
      setState(() {});
    });

    sourceFocus.addListener(() {
      sourceLocation.selection =
          TextSelection.collapsed(offset: sourceLocation.text.length);
      if (sourceFocus.hasFocus) sourceLocation.clear();
    });

    desFocus.addListener(() {
      if (desFocus.hasFocus) {
        if (mLocation.isNotEmpty) {
          sourceLocation.text = mLocation;
          sourceLocation.selection =
              TextSelection.collapsed(offset: sourceLocation.text.length);
        } else {
          sourceLocation.text = widget.title;
          sourceLocation.selection =
              TextSelection.collapsed(offset: sourceLocation.text.length);
        }
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Observer(builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //     alignment: Alignment.center,
              //     margin: EdgeInsets.only(bottom: 16),
              //     height: 5,
              //     width: 70,
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.circular(defaultRadius)),
              //   ),
              // ),
              // Row(
              //   children: [
              //     // Image.asset(
              //     //   "assets/icons/location.png",
              //     //   height: 25,
              //     //   width: 25,
              //     // ),
              //     IconButton(
              //         onPressed: () {
              //           // controller.destinationController.clear();
              //         },
              //         autofocus: false,
              //         icon:
              //             SvgPicture.asset('assets/images/closeIcon.svg')),
              //     Expanded(
              //       child: InkWell(
              //         onTap: () async {
              //           // await controller
              //           //     .placeSelectAPI(context)
              //           //     .then((value) {
              //           //   if (value != null) {
              //           //     controller.destinationController.text =
              //           //         value.result.formattedAddress.toString();
              //           //     setDestinationMarker(LatLng(
              //           //         value.result.geometry!.location.lat,
              //           //         value.result.geometry!.location.lng));
              //           //   }
              //           // });
              //         },
              //         child: TextField(
              //           controller: sourceLocation,
              //           textInputAction: TextInputAction.done,
              //           style: TextStyle(color: Color(0xff242123)),
              //           decoration: InputDecoration(
              //             hintText: "تحديد موقع الوجهة",
              //             border: InputBorder.none,
              //             focusedBorder: InputBorder.none,
              //             enabled: true,
              //           ),
              //         ),

              //         //  buildTextField(
              //         //   title: "تحديد موقع الوجهة",
              //         //   textController: sourceLocation,
              //         // ),
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {},
              //       autofocus: false,
              //       icon: const Icon(
              //         Icons.arrow_forward_ios_sharp,
              //         size: 18,
              //       ),
              //     ),
              //   ],
              // ),

              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(top: 16),
                    //   child: Column(
                    //     children: [
                    //       Icon(Icons.near_me, color: Colors.green),
                    //       SizedBox(height: 4),
                    //       SizedBox(
                    //         height: 60,
                    //         child: DottedLine(
                    //           direction: Axis.vertical,
                    //           lineLength: double.infinity,
                    //           lineThickness: 1,
                    //           dashLength: 2,
                    //           dashColor: primaryColor,
                    //         ),
                    //       ),
                    //       SizedBox(height: 4),
                    //       Icon(Icons.location_on, color: Colors.red),
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(width: 16),
                    IconButton(
                        onPressed: () {
                          sourceLocation.clear();
                          widget.destinationLocation.clear();
                          appStore.setIsDestinationConfirmed(false);
                          appStore.setIsDestinationSelected(false);
                          appStore.setStartSelectedAdress('');
                        },
                        icon: SvgPicture.asset('images/closeIcon.svg')),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, right: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: widget.destinationLocation,
                              focusNode: sourceFocus,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: Color(0xff242123), fontSize: 14),

                              decoration: InputDecoration(
                                hintText:
                                    appStore.selectedStartAddress == null ||
                                            appStore.selectedStartAddress == ""
                                        ? 'تحديد موقع  الخدمة'
                                        : appStore.selectedStartAddress,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14),
                                focusedBorder: InputBorder.none,
                                enabled: true,
                              ),
                              // decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(vertical: 8),
                              //     isDense: true,
                              //     hintStyle: primaryTextStyle(),
                              //     labelStyle: primaryTextStyle(),
                              //     hintText: language.currentLocation),
                              onTap: () {
                                isPickup = false;
                                setState(() {});
                              },
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  isPickup = true;
                                  if (val.length < 3) {
                                    isDone = false;
                                    listAddress.clear();
                                    setState(() {});
                                  } else {
                                    searchAddressRequest(search: val)
                                        .then((value) {
                                      isDone = true;
                                      listAddress = value.predictions!;
                                      setState(() {});
                                    }).catchError((error) {
                                      log(error);
                                    });
                                  }
                                } else {
                                  isPickup = false;
                                  setState(() {});
                                }
                              },
                            ),

                            // if (isDrop == true)
                            //   Text(language.lblDropOff,
                            //       style: secondaryTextStyle()),
                            // TextFormField(
                            //   controller: destinationLocation,
                            //   focusNode: desFocus,
                            //   autofocus: true,
                            //   decoration: InputDecoration(
                            //       contentPadding:
                            //           EdgeInsets.symmetric(vertical: 8),
                            //       isDense: true,
                            //       hintStyle: primaryTextStyle(),
                            //       labelStyle: primaryTextStyle(),
                            //       hintText: language.destinationLocation),
                            //   onTap: () {
                            //     isDrop = false;
                            //     setState(() {});
                            //   },
                            //   onChanged: (val) {
                            //     if (val.isNotEmpty) {
                            //       isDrop = true;
                            //       if (val.length < 3) {
                            //         listAddress.clear();
                            //         setState(() {});
                            //       } else {
                            //         searchAddressRequest(search: val)
                            //             .then((value) {
                            //           listAddress = value.predictions!;
                            //           setState(() {});
                            //         }).catchError((error) {
                            //           log(error);
                            //         });
                            //       }
                            //     } else {
                            //       isDrop = false;
                            //       setState(() {});
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       appStore.setIsSourceConfirmed(false);
                    //     },
                    //     child: Text(
                    //       'رجوع',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     style: ButtonStyle(
                    //       backgroundColor:
                    //           MaterialStateProperty.all<Color>(Colors.black),
                    //     ),
                    //   ),
                    // )
                    // IconButton(
                    //   onPressed: () {
                    //     appStore.setIsSourceConfirmed(false);
                    //   },
                    //   autofocus: false,
                    //   icon: const Icon(
                    //     Icons.arrow_forward_ios_sharp,
                    //     size: 18,
                    //   ),
                    // ),
                  ],
                ),
              ),
              if (listAddress.isNotEmpty) SizedBox(height: 16),
              ListView.builder(
                controller: ScrollController(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: listAddress.length,
                itemBuilder: (context, index) {
                  Prediction mData = listAddress[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        Icon(Icons.location_on_outlined, color: primaryColor),
                    minLeadingWidth: 16,
                    title: Text(mData.description ?? "",
                        style: primaryTextStyle()),
                    onTap: () async {
                      await searchAddressRequestPlaceId(placeId: mData.placeId)
                          .then((value) async {
                        var data = value.result!.geometry;

                        widget.destinationLocation.text = mData.description!;
                        polylineDestination =
                            LatLng(data!.location!.lat!, data.location!.lng!);
                        appStore.setIsDestinationSelected(true);
                        if (widget.destinationLocation.text.isNotEmpty) {
                          appStore.setStartSelectedAdress(
                              widget.destinationLocation.text);
                          // launchScreen(
                          //     context,
                          //     NewEstimateRideListWidget(
                          //         sourceLatLog: polylineSource,
                          //         destinationLatLog: polylineDestination,
                          //         sourceTitle:
                          //             appStore.selectedStartAddress ?? "",
                          //         destinationTitle: destinationLocation.text),
                          //     pageRouteAnimation:
                          //         PageRouteAnimation.SlideBottomTop);

                          // sourceLocation.clear();
                          // destinationLocation.clear();
                        }

                        listAddress.clear();
                        setState(() {});
                      }).catchError((error) {
                        log(error);
                      });
                    },
                  );
                },
              ),
              // AppButtonWidget(
              //   width: MediaQuery.of(context).size.width,
              //   onTap: () async {
              //     if (sourceFocus.hasFocus) {
              //       isDone = true;
              //       PickResult selectedPlace = await launchScreen(
              //           context, GoogleMapScreen(isDestination: false),
              //           pageRouteAnimation:
              //               PageRouteAnimation.SlideBottomTop);
              //       log(selectedPlace);
              //       mLocation = selectedPlace.formattedAddress!;
              //       sourceLocation.text = selectedPlace.formattedAddress!;
              //       polylineSource = LatLng(
              //           selectedPlace.geometry!.location.lat,
              //           selectedPlace.geometry!.location.lng);

              //       if (sourceLocation.text.isNotEmpty &&
              //           destinationLocation.text.isNotEmpty) {
              //         log(sourceLocation.text);
              //         log(destinationLocation.text);

              //         launchScreen(
              //             context,
              //             NewEstimateRideListWidget(
              //                 sourceLatLog: polylineSource,
              //                 destinationLatLog: polylineDestination,
              //                 sourceTitle: sourceLocation.text,
              //                 destinationTitle: destinationLocation.text),
              //             pageRouteAnimation:
              //                 PageRouteAnimation.SlideBottomTop);

              //         sourceLocation.clear();
              //         destinationLocation.clear();
              //       }
              //     } else if (desFocus.hasFocus) {
              //       PickResult selectedPlace = await launchScreen(
              //           context, GoogleMapScreen(isDestination: true),
              //           pageRouteAnimation:
              //               PageRouteAnimation.SlideBottomTop);

              //       destinationLocation.text =
              //           selectedPlace.formattedAddress!;
              //       polylineDestination = LatLng(
              //           selectedPlace.geometry!.location.lat,
              //           selectedPlace.geometry!.location.lng);

              //       if (sourceLocation.text.isNotEmpty &&
              //           destinationLocation.text.isNotEmpty) {
              //         log(sourceLocation.text);
              //         log(destinationLocation.text);

              //         launchScreen(
              //             context,
              //             NewEstimateRideListWidget(
              //                 sourceLatLog: polylineSource,
              //                 destinationLatLog: polylineDestination,
              //                 sourceTitle: sourceLocation.text,
              //                 destinationTitle: destinationLocation.text),
              //             pageRouteAnimation:
              //                 PageRouteAnimation.SlideBottomTop);

              //         sourceLocation.clear();
              //         destinationLocation.clear();
              //       }
              //     } else {
              //       //
              //     }
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.my_location_sharp, color: Colors.white),
              //       SizedBox(width: 16),
              //       Text(language.chooseOnMap,
              //           style: boldTextStyle(color: Colors.white)),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
