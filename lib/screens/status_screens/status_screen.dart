import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/status_screens/status_screen2.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _start = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        // الانتقال إلى الشاشة التالية عند الوصول للصفر
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => StatusScreen2()),
        );
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                  SizedBox(
                    height: context.statusBarHeight + 4,
                  ),
                  CustomRowWidget(),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 120.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'تـم التأكـيد',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'متخصص غسل سيارتك',
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
                      width: 680.h,
                      child: Text(
                        'سيكون في موقعك خـلال',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _start < 10 ? '00:0$_start' : '00:$_start',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Color(0xff201B51),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'سوف يقوم بإعلامك عندما يصـل',
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
                                    color: appTheme.primary,
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
