import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/main_screen/main_screen.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import '../../components/drawer_component.dart';
import '../../network/RestApis.dart';
import '../../utils/Common.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/custom_button_style.dart';
import '../../utils/Extensions/custom_elevated_button.dart';
import '../../utils/Extensions/custom_text_form_field.dart';
import '../../utils/Extensions/theme_helper.dart';
import '../additional_services/additional_services_screen.dart';
import '../packages/select_car_screen.dart';

class SucessContactUsScreen extends StatefulWidget {
  const SucessContactUsScreen({super.key});

  @override
  State<SucessContactUsScreen> createState() => _SucessContactUsScreenState();
}

class _SucessContactUsScreenState extends State<SucessContactUsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {});
  }

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
                  topWidget(_scaffoldKey),
                  SizedBox(
                    height: 120.v,
                  ),
                  Image.asset(
                    'images/arrow.jpeg',
                    height: 220.v,
                  ),
                  SizedBox(
                    height: 60.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Message sent',
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 60.v,
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'Your message has been sent.',
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
                        'We will review it and get back to you',
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
                        'as soon as possible on your',
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
                        'registered email:',
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
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'Abdullah@gmail.com',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
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
                        'Thank you for your patience.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100.v,
            child: Align(
              alignment: Alignment.center,
              child: CustomElevatedButton(
                text: 'Back to home page',
                height: 122.v,
                width: 637.h,
                buttonTextStyle: TextStyle(
                  color: appTheme.secondry,
                  fontSize: 16,
                ),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onPressed: () {
                  launchScreen(context, MainScreen(), isNewTask: false);
                },
              ),
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
