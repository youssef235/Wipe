import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/status_screens/status_screen3.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../components/drawer_component.dart';

class StatusScreen2 extends StatefulWidget {
  const StatusScreen2({super.key});

  @override
  State<StatusScreen2> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.primary,
      drawer: DrawerComponent(),
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
                  SizedBox(
                    height: context.statusBarHeight + 4,
                  ),
                  CustomRowWidget(),
                  SizedBox(
                    height: 120.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '! متخصص الغسل قد وصل',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'لقد بدأت عملية غسيل السيارة الخاصة بك.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'سوف نقوم بإعلامك عند إكتمال غسل السيارة',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.v,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 5.h,
                          width: 600.h,
                          decoration: BoxDecoration(
                            color: appTheme.secondry,
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          left: 0,
                          // bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.secondry,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 140.h,
                                child: Text(
                                  'الغسل تم جدولته',
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          right: 0,
                          // bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.primary,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 140.h,
                                child: Text(
                                  'تمت عملية الغسل',
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          right: 0,
                          left: 0,
                          // bottom: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.secondry,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 160.h,
                                child: Text(
                                  'بدأت عملية الغسل',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 520.v),
                  Confirmbutton(
                    text: " تأكـيد ",
                    color: appTheme.secondry,
                    textColor: appTheme.primary,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 100.v,
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: CustomElevatedButton(
          //       text: 'Checkout',
          //       height: 122.v,
          //       width: 637.h,
          //       buttonTextStyle: TextStyle(
          //         color: appTheme.secondry,
          //         fontSize: 16,
          //       ),
          //       buttonStyle: CustomButtonStyles.fillPrimary,
          //       onPressed: () {
          //         //  launchScreen(context, SelectCarScreen(), isNewTask: false);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Confirmbutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  Confirmbutton({
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatusScreen3(
                // التاريخ المختار
                ),
          ),
        );
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: textColor),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
