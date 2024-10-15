import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import '../../utils/Constants.dart';
import '../../utils/Extensions/app_common.dart';
import '../main.dart';
import '../utils/Common.dart';
import '../utils/Extensions/StringExtensions.dart';
import 'EditProfileScreen.dart';
import 'get_started_screen.dart';
import 'main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 3));
    if (sharedPref.getBool(IS_FIRST_TIME) ?? true) {
      await Geolocator.requestPermission().then((value) async {
        await Geolocator.getCurrentPosition().then((value) {
          sharedPref.setDouble(LATITUDE, value.latitude);
          sharedPref.setDouble(LONGITUDE, value.longitude);
          launchScreen(context, GetStartedScreen(),
              pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
        });
      }).catchError((e) {
        launchScreen(context, GetStartedScreen(),
            pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
      });
    } else {
      if (!appStore.isLoggedIn) {
        // launchScreen(context, SignInScreen(),
        //     pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
        launchScreen(context, GetStartedScreen(),
            pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
      } else {
        if (sharedPref.getString(CONTACT_NUMBER).validate().isEmptyOrNull) {
          launchScreen(context, EditProfileScreen(isGoogle: true),
              isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
        } else {
          if (await checkPermission())
            await Geolocator.requestPermission().then((value) async {
              await Geolocator.getCurrentPosition().then((value) {
                sharedPref.setDouble(LATITUDE, value.latitude);
                sharedPref.setDouble(LONGITUDE, value.longitude);
                launchScreen(context, MainScreen(),
                    pageRouteAnimation: PageRouteAnimation.Slide,
                    isNewTask: true);
              });
            }).catchError((e) {
              launchScreen(context, MainScreen(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                  isNewTask: true);
            });
        }
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4CC3E5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            'images/splash_logo.svg',
            fit: BoxFit.contain,
            width: 518.68.h,
            height: 140.78.v,
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:video_player/video_player.dart';
// import '../utils/Common.dart';
// import '../utils/Extensions/StringExtensions.dart';
// import '../main.dart';
// import '../../utils/Colors.dart';
// import '../../utils/Constants.dart';
// import '../../utils/Extensions/app_common.dart';
// import '../network/RestApis.dart';
// import '../utils/images.dart';
// import 'EditProfileScreen.dart';
// import 'SignInScreen.dart';
// import 'DashBoardScreen.dart';
// import 'sign_in_screen.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Image.asset(
//         'images/splash.png',
//         width: MediaQuery.of(context).size.width,
//         fit: BoxFit.cover,
//       ),
//     );
//     // return Scaffold(
//     //     backgroundColor: primaryColor,
//     //     body: _controller.value.isInitialized
//     //         ? VideoPlayer(_controller)
//     //         : Container());
//   }
// }
