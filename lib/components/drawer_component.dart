import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxi_booking/screens/DashBoardScreen.dart';
import 'package:taxi_booking/screens/NotificationScreen.dart';
import 'package:taxi_booking/screens/main_screen/main_screen.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import '../model/WalletListModel.dart';
import '../screens/packages/packages_screen.dart';
import '../screens/subscriptions/subscriptions_screen.dart';
import '../utils/Extensions/StringExtensions.dart';
import '../main.dart';
import '../network/RestApis.dart';
import '../screens/BankInfoScreen.dart';
import '../screens/EditProfileScreen.dart';
import '../screens/EmergencyContactScreen.dart';
import '../screens/RideListScreen.dart';
import '../screens/WalletScreen.dart';
import '../screens/SettingScreen.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/ConformationDialog.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/images.dart';
import 'DrawerWidget.dart';

class DrawerComponent extends StatefulWidget {
  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  int currentPage = 1;
  int totalPage = 1;

  int currentIndex = -1;

  List<WalletModel> walletData = [];

  int totalAmount = 0;
  @override
  void initState() {
    getWalletList(page: currentPage).then((value) {
      appStore.setLoading(false);

      currentPage = value.pagination!.currentPage!;
      totalPage = value.pagination!.totalPages!;
      if (value.walletBalance != null)
        totalAmount = value.walletBalance!.totalAmount!.toInt();
      if (currentPage == 1) {
        walletData.clear();
      }
      walletData.addAll(value.data ?? []);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 275,
                  color: primaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Observer(builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80),
                          Column(
                            children: [
                              ClipOval(
                                child: commonCachedNetworkImage(
                                  appStore.userProfile.validate().validate(),
                                  height: 88,
                                  width: 88,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 8),
                              SizedBox(height: 10),
                              Text(
                                sharedPref.getString(FIRST_NAME) ??
                                    "محمد" +
                                        " " +
                                        (sharedPref.getString(LAST_NAME) ??
                                            "علي"),
                                style: boldTextStyle()
                                    .copyWith(color: Color(0xffC1C0C9)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          SizedBox(height: 10),
                          Container(
                            width: 130,
                            height: 27,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                launchScreen(context, WalletScreen(),
                                    pageRouteAnimation:
                                        PageRouteAnimation.Slide);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 16,
                                    color: Color(0xffC1C0C9),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                        (totalAmount.toStringAsFixed(
                                                digitAfterDecimal)) +
                                            'رصيد',
                                        style: boldTextStyle(
                                            size: 15,
                                            color: Colors.black,
                                            weight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //     sharedPref
                              //             .getString(FIRST_NAME)
                              //             .validate()
                              //             .capitalizeFirstLetter() +
                              //         " " +
                              //         sharedPref
                              //             .getString(LAST_NAME)
                              //             .validate()
                              //             .capitalizeFirstLetter(),
                              //     style: boldTextStyle()),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      DrawerWidget(
                        title: 'الرئيسية',
                        iconData: 'images/notification.png',
                        onTap: () {
                          Navigator.pop(context);
                          launchScreen(context, MainScreen(),
                              pageRouteAnimation: PageRouteAnimation.Slide,
                              isNewTask: true);
                        },
                      ),
                      DrawerWidget(
                        title: 'طلب غسيل',
                        iconData: 'images/notification.png',
                        onTap: () {
                          Navigator.pop(context);
                          launchScreen(context, DashBoardScreen(),
                              pageRouteAnimation: PageRouteAnimation.Slide,
                              isNewTask: true);
                        },
                      ),
                      DrawerWidget(
                        title: language.profile,
                        iconData: ic_my_profile,
                        onTap: () {
                          Navigator.pop(context);
                          launchScreen(context, EditProfileScreen(),
                              pageRouteAnimation: PageRouteAnimation.Slide);
                        },
                      ),
                      DrawerWidget(
                          title: language.rides_history,
                          iconData: ic_my_rides,
                          onTap: () {
                            Navigator.pop(context);
                            launchScreen(context, RideListScreen(),
                                pageRouteAnimation: PageRouteAnimation.Slide);
                          }),
                      // DrawerWidget(
                      //   title: 'الاشتراكات',
                      //   iconData: 'images/subscription.png',
                      //   onTap: () {
                      //     Navigator.pop(context);

                      //     launchScreen(
                      //       context,
                      //       SubscriptionsScreen(),
                      //       pageRouteAnimation: PageRouteAnimation.Slide,
                      //     );
                      //   },
                      // ),
                      // DrawerWidget(
                      //   title: 'الباقات المميزة',
                      //   iconData: 'images/subscription.png',
                      //   onTap: () {
                      //     Navigator.pop(context);

                      //     launchScreen(
                      //       context,
                      //       PackagesScreen(),
                      //       pageRouteAnimation: PageRouteAnimation.Slide,
                      //     );
                      //   },
                      // ),

                      DrawerWidget(
                          title: 'التنبيهات',
                          iconData: ic_my_rides,
                          onTap: () {
                            Navigator.pop(context);
                            launchScreen(context, NotificationScreen(),
                                pageRouteAnimation: PageRouteAnimation.Slide);
                          }),
                      DrawerWidget(
                          title: language.wallet,
                          iconData: ic_my_wallet,
                          onTap: () {
                            Navigator.pop(context);
                            launchScreen(context, WalletScreen(),
                                pageRouteAnimation: PageRouteAnimation.Slide);
                          }),
                      // DrawerWidget(
                      //     title: language.bankInfo,
                      //     iconData: ic_update_bank_info,
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //       launchScreen(context, BankInfoScreen(),
                      //           pageRouteAnimation: PageRouteAnimation.Slide);
                      //     }),
                      // DrawerWidget(
                      //     title: language.emergencyContacts,
                      //     iconData: ic_emergency_contact,
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //       launchScreen(context, EmergencyContactScreen(),
                      //           pageRouteAnimation: PageRouteAnimation.Slide);
                      //     }),
                      DrawerWidget(
                          title: language.settings,
                          iconData: ic_setting,
                          onTap: () {
                            Navigator.pop(context);
                            launchScreen(context, SettingScreen(),
                                pageRouteAnimation: PageRouteAnimation.Slide);
                          }),
                      DrawerWidget(
                          title: language.logOut,
                          iconData: ic_logout,
                          onTap: () async {
                            await showConfirmDialogCustom(context,
                                primaryColor: primaryColor,
                                dialogType: DialogType.CONFIRMATION,
                                title:
                                    language.areYouSureYouWantToLogoutThisApp,
                                positiveText: language.yes,
                                negativeText: language.no, onAccept: (v) async {
                              await appStore.setLoggedIn(true);
                              await Future.delayed(Duration(milliseconds: 500));
                              await logout();
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
