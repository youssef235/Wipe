// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_booking/main.dart';
import 'package:taxi_booking/model/LoginResponse.dart';
import 'package:taxi_booking/screens/main_screen/main_screen.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import '../aWidgets/language_app_bar.dart';
import '../network/RestApis.dart';
import '../service/firebase_otp_service.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/custom_button_style.dart';
import '../utils/Extensions/custom_elevated_button.dart';
import '../utils/Extensions/custom_text_form_field.dart';
import '../utils/Extensions/theme_helper.dart';
import 'DashBoardScreen.dart';

class OtpScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? verificationId;

  OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _remainingSeconds = 30;
  final TextEditingController otpController = TextEditingController();
  Timer? _timer;
  bool _isLoading = false; // متغير لتحميل حالة

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.v),
            LanguageAppBar(),
            SizedBox(height: 180.v),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 752.h,
                height: 1568.v,
                decoration: BoxDecoration(
                  color: appTheme.secondry,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46),
                    topRight: Radius.circular(46),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50.v),
                    Text('الرجاء إدخال رمز التحقق',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 50.v),
                    Text(
                      'تم إرسال الرمز التعريفي الخاص بك إلى ${widget.phoneNumber}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text('في رسالة نصية عبر رقمك الجوال',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 80.v),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        textAlign: TextAlign.center,
                        height: 120.h,
                        fillColor: appTheme.primary,
                        filled: true,
                        controller: otpController,
                        hintText: 'رمز التأكيد',
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(height: 50.v),
                    Text(
                      '00:${_remainingSeconds.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 150.v),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        :CustomElevatedButton(
                      text: 'إستمرار',
                      height: 122.v,
                      width: 637.h,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        if (otpController.text.isEmpty || otpController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى إدخال رمز OTP صحيح')),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }

                        final phoneNumber = '+20${widget.phoneNumber?.substring(1)}';

                        try {
                          VerifyOtpResponse response = await verifyOtpApi({
                            'phoneNumber': phoneNumber,
                            'sessionInfo': widget.verificationId!,
                            'code': otpController.text,
                          });

                          if (response.message == null) {
                            // حفظ حالة تسجيل الدخول
                            await sharedPref.setBool('isLoggedIn', true);

                            // الحصول على التوكن من SharedPreferences
                            String? token = sharedPref.getString(TOKEN);

                            if (token != null) {
                              print('Token: $token');
                            } else {
                              print('Token not found in SharedPreferences.');
                            }

                            // التوجيه إلى الشاشة الرئيسية
                            launchScreen(context, MainScreen(), isNewTask: true);
                            FocusScope.of(context).unfocus();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('فشل التحقق من OTP: ${response.message}')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('حدث خطأ: $e')),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      buttonStyle: CustomButtonStyles.fillSecondry,
                    )



                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// // ignore_for_file: must_be_immutable

// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pinput/pinput.dart';
// import 'package:taxi_booking/main.dart';
// import 'package:taxi_booking/utils/Colors.dart';

// import '../network/RestApis.dart';
// import '../utils/Extensions/app_common.dart';
// import '../utils/Extensions/custom_button.dart';
// import '../utils/Extensions/show_toast_dialog.dart';
// import 'otp_sucess_screen.dart';

// class OtpScreen extends StatelessWidget {
//   String? phoneNumber;

//   OtpScreen({
//     super.key,
//     required this.phoneNumber,
//   });

//   final textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           // decoration: const BoxDecoration(
//           //   image: DecorationImage(
//           //     image: AssetImage("assets/images/login_bg.png"),
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 22),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 80,
//                       ),

//                       SizedBox(
//                         height: 26,
//                       ),
//                       Text(
//                         'رمز التحقق',
//                         style: const TextStyle(
//                             letterSpacing: 0.60,
//                             fontSize: 22,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w900),
//                       ),
//                       Text(
//                         'تم أرسال رقم التحقق الى رقمك المسجل معنا',
//                         style: const TextStyle(
//                             fontSize: 12,
//                             color: Color(0xff757575),
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         phoneNumber ?? "",
//                         textDirection: TextDirection.rtl,
//                         style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xff757575),
//                             fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 85,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: Directionality(
//                           textDirection: TextDirection.ltr,
//                           child: Pinput(
//                             controller: textEditingController,
//                             defaultPinTheme: PinTheme(
//                               height: 50,
//                               width: 50,

//                               textStyle: const TextStyle(
//                                   letterSpacing: 0.60,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600),
//                               // margin: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.white,
//                                 border:
//                                     Border.all(color: Colors.black, width: 0.7),
//                               ),
//                             ),
//                             keyboardType: TextInputType.phone,
//                             textInputAction: TextInputAction.done,
//                             length: 6,
//                           ),
//                         ),

//                         // PinCodeTextField(
//                         //   length: 6,
//                         //   appContext: context,
//                         //   keyboardType: TextInputType.phone,
//                         //   textInputAction: TextInputAction.done,
//                         //   pinTheme: PinTheme(
//                         //     fieldHeight: 50,
//                         //     fieldWidth: 50,
//                         //     activeColor: ConstantColors.textFieldBoarderColor,
//                         //     selectedColor:
//                         //         ConstantColors.textFieldBoarderColor,
//                         //     inactiveColor:
//                         //         ConstantColors.textFieldBoarderColor,
//                         //     activeFillColor: Colors.white,
//                         //     inactiveFillColor: Colors.white,
//                         //     selectedFillColor: Colors.white,
//                         //     shape: PinCodeFieldShape.box,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //   ),
//                         //   enableActiveFill: true,
//                         //   cursorColor: ConstantColors.primary,
//                         //   controller: textEditingController,
//                         //   onCompleted: (v) async {},
//                         //   onChanged: (value) {
//                         //     log(value);
//                         //   },
//                         // ),
//                       ),
//                       SizedBox(
//                         height: 68,
//                       ),
//                       CustomButton(
//                         onTap: () async {
//                           // Get.off(
//                           //   () => OtpScreenSucess(),
//                           // );
//                           await logInApi({
//                             "contact_number": phoneNumber,
//                             "player_id": sharedPref.getString(''),
//                             "user_type": "rider",
//                             'otp_code': textEditingController.text
//                           }, isSocialLogin: false);
//                           launchScreen(context, OtpScreenSucess());
//                           FocusScope.of(context).unfocus();
//                         },
//                         buttonText: 'التأكيد',
//                         color: primaryColor,
//                         backgroundColor: Colors.white,
//                       ),
//                       // Padding(
//                       //     padding: const EdgeInsets.only(top: 40),
//                       //     child: ButtonThem.buildButton(
//                       //       context,
//                       //       title: 'done'.tr,
//                       //       btnHeight: 50,
//                       //       btnColor: ConstantColors.primary,
//                       //       txtColor: Colors.white,
//                       //       onPress: () async {
//                       //         FocusScope.of(context).unfocus();

//                       //         if (textEditingController.text.length == 6) {
//                       //           ShowToastDialog.showLoader("Verify OTP".tr);
//                       //           PhoneAuthCredential credential =
//                       //               PhoneAuthProvider.credential(
//                       //                   verificationId:
//                       //                       verificationId.toString(),
//                       //                   smsCode: textEditingController.text);
//                       //           await FirebaseAuth.instance
//                       //               .signInWithCredential(credential)
//                       //               .then((value) async {
//                       //             Map<String, String> bodyParams = {
//                       //               'phone': phoneNumber.toString(),
//                       //               'user_cat': "customer",
//                       //             };
//                       //             await controller
//                       //                 .phoneNumberIsExit(bodyParams)
//                       //                 .then((value) async {
//                       //               if (value == true) {
//                       //                 Map<String, String> bodyParams = {
//                       //                   'phone': phoneNumber.toString(),
//                       //                   'user_cat': "customer",
//                       //                 };
//                       //                 await controller
//                       //                     .getDataByPhoneNumber(bodyParams)
//                       //                     .then((value) {
//                       //                   if (value != null) {
//                       //                     if (value.success == "success") {
//                       //                       ShowToastDialog.closeLoader();

//                       //                       Preferences.setInt(
//                       //                           Preferences.userId,
//                       //                           int.parse(
//                       //                               value.data!.id.toString()));
//                       //                       Preferences.setString(
//                       //                           Preferences.user,
//                       //                           jsonEncode(value));
//                       //                       Preferences.setString(
//                       //                           Preferences.accesstoken,
//                       //                           value.data!.accesstoken
//                       //                               .toString());
//                       //                       Preferences.setString(
//                       //                           Preferences.admincommission,
//                       //                           value.data!.adminCommission
//                       //                               .toString());
//                       //                       API.header['accesstoken'] =
//                       //                           Preferences.getString(
//                       //                               Preferences.accesstoken);

//                       //                       if (value.data!.photo == null ||
//                       //                           value.data!.photoPath
//                       //                               .toString()
//                       //                               .isEmpty) {
//                       //                         Get.to(() =>
//                       //                             AddProfilePhotoScreen());
//                       //                       } else {
//                       //                         Preferences.setBoolean(
//                       //                             Preferences.isLogin, true);
//                       //                         Get.offAll(DashBoard());
//                       //                       }
//                       //                     } else {
//                       //                       ShowToastDialog.showToast(
//                       //                           value.error);
//                       //                     }
//                       //                   }
//                       //                 });
//                       //               } else if (value == false) {
//                       //                 ShowToastDialog.closeLoader();
//                       //                 Get.off(SignupScreen(
//                       //                   phoneNumber: phoneNumber.toString(),
//                       //                 ));
//                       //               }
//                       //             });
//                       //           }).catchError((error) {
//                       //             ShowToastDialog.closeLoader();
//                       //             ShowToastDialog.showToast(
//                       //                 "Code is Invalid".tr);
//                       //           });
//                       //         } else {
//                       //           ShowToastDialog.showToast(
//                       //               "Please Enter OTP".tr);
//                       //         }
//                       //       },
//                       //     ))
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                       // decoration: BoxDecoration(
//                       //   borderRadius: BorderRadius.circular(30),
//                       //   color: Colors.white,
//                       //   boxShadow: <BoxShadow>[
//                       //     BoxShadow(
//                       //       color: Colors.black.withOpacity(0.3),
//                       //       blurRadius: 10,
//                       //       offset: const Offset(0, 2),
//                       //     ),
//                       //   ],
//                       // ),
//                       child: const Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Icon(
//                       Icons.arrow_back_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   )),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
