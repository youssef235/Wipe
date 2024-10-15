import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../main.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';

class GoogleMapScreen extends StatefulWidget {
  final bool? isDestination;

  const GoogleMapScreen({super.key, this.isDestination});

  @override
  GoogleMapScreenState createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng kInitialPosition = polylineSource;

  PickResult? selectedPlace;
  bool showPlacePickerInContainer = false;
  bool showGoogleMapInContainer = false;
  bool isDemo = false;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Theme(
            data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
            child: PlacePicker(
              apiKey: GOOGLE_MAP_API_KEY,
              hintText: language.findPlace,
              searchingText: language.pleaseWait,
              selectText: language.selectPlace,
              outsideOfPickAreaText: language.placeNotInArea,
              initialPosition: LatLng(sharedPref.getDouble(LATITUDE)!,
                  sharedPref.getDouble(LONGITUDE)!),
              useCurrentLocation: true,
              selectInitialPosition: true,
              usePinPointingSearch: true,
              usePlaceDetailSearch: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              automaticallyImplyAppBarLeading: false,
              autocompleteLanguage: '',
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle('''
              [
                {
                  "elementType": "geometry",
                  "stylers": [
                    { "color": "#FF0000" }  // لون الخلفية أحمر
                  ]
                },
                {
                  "elementType": "labels.text.fill",
                  "stylers": [
                    { "color": "#FFFFFF" }  // لون النصوص أبيض
                  ]
                },
                {
                  "elementType": "labels.text.stroke",
                  "stylers": [
                    { "visibility": "off" }  // إلغاء حدود النصوص
                  ]
                }
              ]
            ''');
              },
              onPlacePicked: (PickResult result) {
                setState(() {
                  selectedPlace = result;
                  log(selectedPlace!.formattedAddress);
                  Navigator.pop(context, selectedPlace);
                });
              },
            ),
          ),
          if (isDemo == true)
            Container(
              margin: EdgeInsets.only(top: 120),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: radius(),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      spreadRadius: 1),
                ],
              ),
              child: Text(
                'NOTE: Drag-drop address place search is disable \nfor demo user',
                style: secondaryTextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
