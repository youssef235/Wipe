import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../aWidgets/upper_app_bar.dart';
import '../main.dart';
import '../model/CurrentRequestModel.dart';
import '../model/NearByDriverListModel.dart';
import '../model/TextModel.dart';
import '../network/RestApis.dart';
import '../screens/ReviewScreen.dart';
import '../screens/RidePaymentDetailScreen.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/DataProvider.dart';
import '../utils/Extensions/LiveStream.dart';
import '../utils/Extensions/StringExtensions.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/context_extension.dart';
import '../utils/Extensions/custom_button_style.dart';
import '../utils/Extensions/custom_elevated_button.dart';
import '../utils/images.dart';
import 'LocationPermissionScreen.dart';
import 'NewEstimateRideListWidget.dart';
import 'home_screen/widgets/arrive_ride_widget.dart';
import 'packages/packages_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController destinationLocation =
      TextEditingController(text: appStore.selectedStartAddress);

  LatLng? sourceLocation;

  List<TexIModel> list = getBookList();
  List<Marker> markers = [];
  Set<Polyline> _polyLines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  OnRideRequest? servicesListData;

  double cameraZoom = 17.0, cameraTilt = 0;

  double cameraBearing = 30;
  int onTapIndex = 0;

  int selectIndex = 0;
  String sourceLocationTitle = '';

  late StreamSubscription<ServiceStatus> serviceStatusStream;

  LocationPermission? permissionData;

  late BitmapDescriptor riderIcon;
  late BitmapDescriptor driverIcon;
  List<NearByDriverListModel>? nearDriverModel;
  String? _mapStyle;
  @override
  void initState() {
    super.initState();
    locationPermission();
    getCurrentRequest();

    afterBuildCreated(() {
      init();
    });

    _mapStyle = '''
  [  
    {  
      "elementType": "geometry",  
      "stylers": [  
        { "color": "#4CC3E5" }  // خلفية داكنة  
      ]  
    },  
    {  
      "elementType": "labels.text.fill",  
      "stylers": [  
        { "color": "#FFFFFF" }  // نص أبيض لزيادة الوضوح  
      ]  
    },  
    {  
      "elementType": "labels.text.stroke",  
      "stylers": [  
        { "visibility": "off" }  // إيقاف تأثير الظل على النص  
      ]  
    },  
    {  
      "featureType": "road.highway",  
      "elementType": "geometry",  
      "stylers": [  
        { "color": "#FFD700" }  // لون أصفر فاتح للطريق السريع  
      ]  
    },  
    {  
      "featureType": "road",  
      "elementType": "geometry",  
      "stylers": [  
        { "color": "#FFFFFF" }  // لون أبيض لباقي الطرق  
      ]  
    },  
    {  
      "featureType": "road",  
      "elementType": "labels.text.fill",  
      "stylers": [  
        { "color": "#000000" }  // أسماء الشوارع بلون أبيض  
      ]  
    },  
    {  
      "featureType": "water",  
      "stylers": [  
        { "color": "#3A3D9A" }  // لون أزرق فاتح للمياه  
      ]  
    },  
    {  
      "featureType": "poi",  
      "elementType": "geometry",  
      "stylers": [  
        { "color": "#2D2D45" }  // لون المعالم العامة  
      ]  
    },  
    {  
      "featureType": "poi",  
      "elementType": "labels.text.fill",  
      "stylers": [  
        { "color": "#FFFFFF" }  // نص المعالم العامة بلون أصفر فاتح  
      ]  
    },
{  
      "featureType": "administrative",  
      "elementType": "geometry",  
      "stylers": [  
        { "color": "#1A1A2E" }  // لون داكن فاتح للمباني  
      ]  
    }  
  ]  
''';
    afterBuildCreated(() {
      init();
    });
  }

  void init() async {
    getCurrentUserLocation();

    sharedPref.setBool(IS_FIRST_TIME, false);
    riderIcon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48, 48)), 'images/location.png');
    driverIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), MultipleDriver);
    await getAppSetting().then((value) {
      if (value.walletSetting != null) {
        value.walletSetting!.forEach((element) {
          if (element.key == PRESENT_TOPUP_AMOUNT) {
            appStore.setWalletPresetTopUpAmount(
                element.value ?? PRESENT_TOP_UP_AMOUNT_CONST);
          }
          if (element.key == MIN_AMOUNT_TO_ADD) {
            if (element.value != null)
              appStore.setMinAmountToAdd(int.parse(element.value!));
          }
          if (element.key == MAX_AMOUNT_TO_ADD) {
            if (element.value != null)
              appStore.setMaxAmountToAdd(int.parse(element.value!));
          }
        });
      }
      if (value.rideSetting != null) {
        value.rideSetting!.forEach((element) {
          if (element.key == PRESENT_TIP_AMOUNT) {
            appStore.setWalletTipAmount(
                element.value ?? PRESENT_TOP_UP_AMOUNT_CONST);
          }
          if (element.key == RIDE_FOR_OTHER) {
            appStore.setIsRiderForAnother(element.value ?? "0");
          }
          if (element.key == MAX_TIME_FOR_RIDER_MINUTE) {
            appStore.setRiderMinutes(element.value ?? '4');
          }
        });
      }
      if (value.currencySetting != null) {
        appStore
            .setCurrencyCode(value.currencySetting!.symbol ?? currencySymbol);
        appStore
            .setCurrencyName(value.currencySetting!.code ?? currencyNameConst);
        appStore.setCurrencyPosition(value.currencySetting!.position ?? LEFT);
      }
      if (value.settingModel != null) {
        appStore.settingModel = value.settingModel!;
      }
      if (value.privacyPolicyModel!.value != null)
        appStore.privacyPolicy = value.privacyPolicyModel!.value!;
      if (value.termsCondition!.value != null)
        appStore.termsCondition = value.termsCondition!.value!;
      if (value.settingModel!.helpSupportUrl != null)
        appStore.mHelpAndSupport = value.settingModel!.helpSupportUrl!;
    }).catchError((error) {
      log('${error.toString()}');
    });
    polylinePoints = PolylinePoints();
  }

  Future<void> getCurrentUserLocation() async {
    if (permissionData != LocationPermission.denied) {
      final geoPosition = await Geolocator.getCurrentPosition(
              timeLimit: Duration(seconds: 30),
              desiredAccuracy: LocationAccuracy.high)
          .catchError((error) async {
        if (await checkPermission()) {
          await Geolocator.getCurrentPosition().then((value) {
            sharedPref.setDouble(LATITUDE, value.latitude);
            sharedPref.setDouble(LONGITUDE, value.longitude);
          });
          //  Navigator.pop(context);
        }
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (_) => LocationPermissionScreen()));
      });
      sourceLocation = LatLng(geoPosition.latitude, geoPosition.longitude);
      List<Placemark>? placemarks = await placemarkFromCoordinates(
          geoPosition.latitude, geoPosition.longitude);
      sharedPref.setString(COUNTRY,
          placemarks[0].isoCountryCode.validate(value: defaultCountry));

      Placemark place = placemarks[0];
      if (place != null) {
        sourceLocationTitle =
            "${place.name != null ? place.name : place.subThoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
        polylineSource = LatLng(geoPosition.latitude, geoPosition.longitude);
      }
      markers.add(
        Marker(
          markerId: MarkerId('sourceMarker'),
          position: sourceLocation!,
          draggable: true,
          infoWindow: InfoWindow(title: sourceLocationTitle, snippet: ''),
          icon: riderIcon,
        ),
      );
      startLocationTracking();

      getNearByDriverList(latLng: sourceLocation).then((value) async {
        value.data!.forEach((element) {
          markers.add(
            Marker(
              markerId: MarkerId('Driver${element.id}'),
              position: LatLng(double.parse(element.latitude!.toString()),
                  double.parse(element.longitude!.toString())),
              infoWindow: InfoWindow(
                  title: '${element.firstName} ${element.lastName}',
                  snippet: ''),
              icon: driverIcon,
            ),
          );
        });
        setState(() {});
      });
      setState(() {});
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => LocationPermissionScreen()));
    }
  }

  void _onCamerIdle() {
    getAddressFromLatLng(sourceLocation!.latitude, sourceLocation!.longitude)
        .then((val) {
      setState(() {
        appStore.setIsDestinationSelected(true);

        destinationLocation.clear();
        appStore.setStartSelectedAdress(val.results?[0].formattedAddress ?? "");
      });
    });
  }

  void _onCameraMove(CameraPosition position) async {
    setState(() {
      sourceLocation = position.target;
      markers.removeWhere((marker) => marker.markerId.value == 'sourceMarker');
      markers.add(Marker(
        markerId: MarkerId('sourceMarker'),
        position: position.target,
        draggable: true,
        icon: riderIcon,
        onDragEnd: (newPosition) {
          print('New Position: $newPosition');
          // You can call a function here to handle the new position
        },
      ));
      polylineDestination =
          LatLng(position.target.latitude, position.target.longitude);
    });
  }

  Future<void> getCurrentRequest() async {
    await getCurrentRideRequest().then((value) {
      servicesListData = value.rideRequest ?? value.onRideRequest;
      if (servicesListData != null) {
        if (servicesListData!.status != COMPLETED) {
          launchScreen(
            getContext,
            isNewTask: true,
            NewEstimateRideListWidget(
              sourceLatLog: LatLng(
                  double.parse(servicesListData!.startLatitude!),
                  double.parse(servicesListData!.startLongitude!)),
              destinationLatLog: LatLng(
                  double.parse(servicesListData!.endLatitude!),
                  double.parse(servicesListData!.endLongitude!)),
              sourceTitle: servicesListData!.startAddress!,
              destinationTitle: servicesListData!.endAddress!,
              isCurrentRequest: true,
              servicesId: servicesListData!.serviceId,
              id: servicesListData!.id,
            ),
            pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
          );
        } else if (servicesListData!.status == COMPLETED &&
            servicesListData!.isRiderRated == 0) {
          launchScreen(
              context,
              ReviewScreen(
                  rideRequest: servicesListData!, driverData: value.driver),
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
              isNewTask: true);
        }
      } else if (value.payment != null &&
          value.payment!.paymentStatus != COMPLETED) {
        launchScreen(context,
            RidePaymentDetailScreen(rideId: value.payment!.rideRequestId),
            pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
            isNewTask: true);
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> locationPermission() async {
    serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.disabled) {
        launchScreen(navigatorKey.currentState!.overlay!.context,
            LocationPermissionScreen());
      } else if (status == ServiceStatus.enabled) {
        getCurrentUserLocation();

        if (Navigator.canPop(navigatorKey.currentState!.overlay!.context)) {
          Navigator.pop(navigatorKey.currentState!.overlay!.context);
        }
      }
    }, onError: (error) {
      //
    });
  }

  Future<void> startLocationTracking() async {
    Map req = {
      // "status": "active",
      "latitude": sourceLocation!.latitude.toString(),
      "longitude": sourceLocation!.longitude.toString(),
    };

    await updateStatus(req).then((value) {}).catchError((error) {
      log(error);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle); // تأكد من تطبيق النمط
    // تعيين زوم الخريطة عند الدخول
    controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(sourceLocation!.latitude,
            sourceLocation!.longitude), // موقع المستخدم
        zoom: 1, // زوم بعيد
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    LiveStream().on(CHANGE_LANGUAGE, (p0) {
      setState(() {});
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      //  drawer: DrawerComponent(),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: appTheme.primary,
            width: 800.h,
            height: 1920.v,
          ),
          Positioned(
            top: context.statusBarHeight - 8,
            right: 8,
            left: 8,
            child: CustomRowWidget(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(46),
            child: Container(
              height: 1117.v,
              width: 752.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (sharedPref.getDouble(LATITUDE) != null &&
                      sharedPref.getDouble(LONGITUDE) != null)
                    GoogleMap(
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      style: _mapStyle,
                      onCameraMove: _onCameraMove,
                      onMapCreated:
                          _onMapCreated, // تأكد من ربط الخريطة بتطبيق النمط

                      onCameraIdle: _onCamerIdle,
                      markers: markers.map((e) => e).toSet(),
                      polylines: _polyLines,
                      initialCameraPosition: CameraPosition(
                        target: sourceLocation ??
                            LatLng(sharedPref.getDouble(LATITUDE)!,
                                sharedPref.getDouble(LONGITUDE)!),
                        zoom: cameraZoom,
                        tilt: cameraTilt,
                        bearing: cameraBearing,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: appStore.isSourceSelected &&
                    appStore.isSourceConfirmed == false,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      appStore.setIsSourceConfirmed(true);
                      //  controller.deperature.value = true;
                    },
                    child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'تأكيد موقع المغادرة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 120,
            child: Text(
              'من فضلك إختر العنوان',
              style: TextStyle(
                  color: appTheme.secondry,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: appStore.isDestinationSelected &&
                    appStore.isDestinationConfirmed == false,
                child: Positioned(
                  bottom: 20,
                  right: 50,
                  left: 50,
                  child: CustomElevatedButton(
                    text: 'تـأكيد الـعنوان',
                    height: 122.v,
                    width: 637.h,
                    buttonTextStyle: TextStyle(
                      color: appTheme.secondry,
                      fontSize: 16,
                    ),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    onPressed: () async {
                      double latitude = sourceLocation!.latitude;
                      double longitude = sourceLocation!.longitude;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      // حفظ الموقع في SharedPreferences
                      await prefs.setDouble('latitude', latitude);
                      await prefs.setDouble('longitude', longitude);

                      appStore.setIsDestinationConfirmed(true);

                      // الانتقال إلى شاشة PackagesScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PackagesScreen()),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Observer(builder: (context) {
            return Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      // height: 400,
                      width: 200,
                      child: ArriveRiderWidget(
                          title: sourceLocationTitle,
                          destinationLocation: TextEditingController(
                              text: appStore.selectedStartAddress))),
                ));
          }),
          Visibility(
            visible: appStore.isLoading,
            child: loaderWidget(),
          ),
        ],
      ),
    );
  }
}
