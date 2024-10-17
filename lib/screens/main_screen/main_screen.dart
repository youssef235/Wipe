import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_booking/screens/sign_in_screen.dart';
import 'package:taxi_booking/utils/Constants.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import '../../aWidgets/SuccessfulRequestScreen.dart';
import '../../aWidgets/upper_app_bar.dart';
import '../../main.dart';
import '../../network/RestApis.dart';
import '../../utils/Colors.dart';
import '../../utils/Extensions/ConformationDialog.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/custom_button_style.dart';
import '../../utils/Extensions/custom_elevated_button.dart';
import '../../utils/Extensions/theme_helper.dart';
import '../DeleteAccountScreen.dart';
import '../EditProfileScreen.dart';
import '../RideListScreen.dart';
import '../chat_screen/AdminChatScreen.dart';
import '../chat_screen/ChatClient.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences sharedPref;


  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // تهيئة sharedPref
    sharedPref = await SharedPreferences.getInstance();

    // الآن يمكنك استخدام sharedPref
    print("IDDDDDDD${await sharedPref.getInt(USER_ID)}");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.primary,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                //  SizedBox(height: 20),
                  CustomRowWidget(),
                  SizedBox(height: context.statusBarHeight ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'حســـابـــي',
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.v),
                      MainItemWidget(
                        text: 'الرصـيد : 0.00',
                        onTap: () {},
                      ),
                      SizedBox(height: 33.v),
                      MainItemWidget(
                        text: 'تاريخ الغسل',
                        onTap: () {
                          // launchScreen(context, RideListScreen(),
                          //     pageRouteAnimation: PageRouteAnimation.Slide);
                launchScreen(context, SuccessfulRequestScreen(),
                pageRouteAnimation: PageRouteAnimation.Slide);
                        },
                      ),
                      SizedBox(height: 33.v),
                      MainItemWidget(
                        text: 'معلومات الحساب',
                        onTap: () {
                          launchScreen(context, EditProfileScreen(),
                              pageRouteAnimation: PageRouteAnimation.Slide);
                        },
                      ),
                      SizedBox(height: 33.v),
                      MainItemWidget(
                        text: 'تواصل معنــا',
                        onTap: () async {
                          // استرجاع userId من SharedPreferences
                          final SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          final String? userId = sharedPref.getInt(USER_ID)?.toString(); // تأكد من الحصول على user ID كـ String

                          if (userId == '101') {
                            // إذا كان userId يساوي 100
                            launchScreen(
                              context,
                              AdminChatScreen(),
                              pageRouteAnimation: PageRouteAnimation.Slide,
                              isNewTask: true,
                            );
                          } else {
                            // أي قيمة أخرى
                            launchScreen(
                              context,
                              ChatScreen(isAdmin: false,), // تأكد من أن ClientChatScreen موجودة في مشروعك
                              pageRouteAnimation: PageRouteAnimation.Slide,
                              isNewTask: true,
                            );
                          }
                        },
                      ),

                      SizedBox(height: 80.v),
                      Container(
                        height: 580.v,
                        width: 752.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: appTheme.secondry),
                        child: Column(
                          children: [
                            SizedBox(height: 53.v),
                            Center(
                              child: SizedBox(
                                width: 425.h,
                                child: Text(
                                  'نظف سيارتك أربع مرات وأحصل على الخامسة مجانا!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Text(
                              'الغسل مرة أخرى',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 570.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StageWidget(),
                                  StageWidget(),
                                  StageWidget(),
                                  StageWidget(),
                                  StageWidget(),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.v),
                            MainItemWidget(
                              text: 'أحصل على غستلك المجانية',
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50.v, // زيادة القيمة هنا لتبتعد عن الكارد
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  text: "تسجيل خروج",
                  height: 122.v,
                  width: 300.h, // Ensure the width is set
                  buttonTextStyle: TextStyle(
                    color: appTheme.secondry,
                    fontSize: 16,
                  ),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  onPressed: () async {
                    await showConfirmDialogCustom(context,
                        primaryColor: primaryColor,
                        dialogType: DialogType.CONFIRMATION,
                        title: language.areYouSureYouWantToLogoutThisApp,
                        positiveText: language.yes,
                        negativeText: language.no, onAccept: (v) async {
                          await appStore.setLoggedIn(false);
                          await sharedPref.setBool('isLoggedIn', false); // إزالة حالة تسجيل الدخول
                          launchScreen(context, SignInScreenNew(),
                              pageRouteAnimation: PageRouteAnimation.Slide);
                        });
                  },
                ),
                CustomElevatedButton(
                  text: 'إزالة الحساب',
                  height: 122.v,
                  width: 300.h, // Ensure the width is set
                  buttonTextStyle: TextStyle(
                    color: appTheme.secondry,
                    fontSize: 16,
                  ),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  onPressed: () async {
                    launchScreen(context, DeleteAccountScreen(),
                        pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StageWidget extends StatelessWidget {
  const StageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77.h,
      height: 77.h,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xff4CC3E5)),
    );
  }
}

class MainItemWidget extends StatelessWidget {
  const MainItemWidget({
    super.key,
    this.isSelected,
    required this.text,
    this.onTap,
  });
  final bool? isSelected;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 661.h,
        height: 104.v,
        decoration: BoxDecoration(
            color: isSelected != true ? appTheme.primary : appTheme.secondry,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: appTheme.black90001, width: 1.5)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              text,
              style: TextStyle(
                  color:
                      isSelected == true ? appTheme.primary : appTheme.secondry,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
