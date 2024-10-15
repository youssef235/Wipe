import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/contact_us/sucess_contact_us.dart';
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

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Contact us',
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
                        'Send us a message and we’ll get back to you via email.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80.v,
                      ),
                      CustomTextFormField(
                        borderColor: Colors.black,
                        textAlign: TextAlign.center,
                        borderWidth: 1.5,
                        hintText: 'Subject',
                      ),
                      SizedBox(
                        height: 44.v,
                      ),
                      CustomTextFormField(
                        borderColor: Colors.black,
                        textAlign: TextAlign.center,
                        borderWidth: 1.5,
                        maxLines: 8,
                        hintText: 'Message',
                      ),
                    ],
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
                text: 'Send',
                height: 122.v,
                width: 637.h,
                buttonTextStyle: TextStyle(
                  color: appTheme.secondry,
                  fontSize: 16,
                ),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onPressed: () {
                  launchScreen(context, SucessContactUsScreen(),
                      isNewTask: false);
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
