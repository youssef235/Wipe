import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_booking/screens/sign_in_screen.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../aWidgets/get_start_app_bar.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GetStartAppBar(),
            Spacer(flex: 2),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // توسيط العناصر عمودياً
              children: [
                SvgPicture.asset(
                  'images/splash_logo.svg',
                  fit: BoxFit.fill,
                  width: 85,
                  height: 85,
                ),
                SizedBox(height: 10), // فاصل
        
              ],
            ),
            Spacer(flex: 2),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity, // عرض كامل
                padding: EdgeInsets.symmetric(
                    horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreenNew()),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Container(
                      height: 120, // ارتفاع الكارد
                      decoration: BoxDecoration(
                        color: appTheme.secondry,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Text(
                          'أبـــدأ',
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
