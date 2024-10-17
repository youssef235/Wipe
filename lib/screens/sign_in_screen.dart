import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import '../aWidgets/language_app_bar.dart';
import '../main.dart';
import '../service/firebase_otp_service.dart';
import '../utils/Extensions/app_bar.dart';
import '../utils/Extensions/custom_button_style.dart';
import '../utils/Extensions/custom_elevated_button.dart';
import '../utils/Extensions/custom_text_form_field.dart';
import '../utils/Extensions/theme_helper.dart';
import 'otp_screen.dart';

class SignInScreenNew extends StatefulWidget {
  final bool? isLogin;
  SignInScreenNew({super.key, this.isLogin});

  @override
  State<SignInScreenNew> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreenNew> {
  TextEditingController phoneController = TextEditingController();
  double? width;
  double? height;
  double? padin;
  String? _verificationId;
  final PhoneAuthService _phoneAuthService = PhoneAuthService();
  bool _isLoading = false; // متغير لتحميل حالة

  @override
  void initState() {
    // TODO: implement initState
    width = 118.68.h;
    height = 90.78.v;
    padin = 35.0;
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  bool _isExpanded = false; // حالة التمدد

  void _onIconTap() {
    setState(() {
      // تغيير حالة التمدد
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        width = 0;
        height = 0;
        padin = 0;
      } else {
        width = 118.68.h;
        height = 90.78.v;
        padin = 35.0;
      }
    });
  }

  double _containerWidth = 60.0;

  void _expandContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
      _containerWidth = _isExpanded ? 300.0 : 60.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
    //  appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LanguageAppBar(),
              SizedBox(height: 180.v),
              Container(
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
                    Text(
                      'أدخل رقم الجوال',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 50.v),
                    Text(
                      'أدخل جوالك',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'حتى تبدأ التجربة',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 200.v),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        textAlign: TextAlign.left,
                        height: 120.h,
                        fillColor: appTheme.primary,
                        controller: phoneController,
                        filled: true,
                        validator: (value) {
                          if (value!.isEmpty) return language.thisFieldRequired;
                          return null;
                        },
                        hintText: 'رقم الجوال',
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        suffix: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2),
                          child: Container(
                            width: 150.h,
                            height: 100.v,
                            decoration: BoxDecoration(
                              color: appTheme.secondry,
                              borderRadius: BorderRadius.circular(63),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('966+'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.v),
                    Text(
                      'تطبق الشروط والأحكام',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 150.v),
                    _isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator())
                        : CustomElevatedButton(
                      text: 'إستمر',
                      height: 122.v,
                      width: 637.h,
                      buttonTextStyle:
                      Theme.of(context).textTheme.bodyMedium,
                      buttonStyle: CustomButtonStyles.fillSecondry,
                      onPressed: () async {
                        setState(() {
                          _isLoading =
                          true;
                        });

                        try {
                          await _phoneAuthService.verifyPhoneNumber(
                            phoneController.text,
                                (String verificationId, String phoneNumber) {
                              print ("vvvvvvvvv is ${verificationId}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    verificationId: verificationId,
                                    phoneNumber:
                                    phoneNumber,
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (error) {
                          // التعامل مع الأخطاء
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')),
                          );
                        } finally {
                          if (!_isLoading) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }

                        // FocusScope.of(context).unfocus();
                        // if (phoneController.text.isNotEmpty) {
                        //   final response = await logInApi({
                        //     "contact_number": phoneController.text,
                        //     // "player_id":
                        //     //     sharedPref.getString(PLAYER_ID).validate(),
                        //     "user_type": "rider",
                        //   }, isSocialLogin: false);
                        //
                        //   if (response.data == 'failed') {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //           content:
                        //               Text('فشل التحقق: ${response.message}')),
                        //     );
                        //   } else {
                        //     launchScreen(
                        //       context,
                        //       OtpScreen(
                        //         phoneNumber: phoneController.text,
                        //       ),
                        //     );
                        //   }
                        // }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:taxi_booking/screens/otp_screen.dart';
// import 'package:taxi_booking/utils/Extensions/app_common.dart';

// import '../utils/Colors.dart';
// import '../utils/Extensions/custom_button.dart';
// import '../utils/Extensions/custom_text_field.dart';
// import '../utils/Extensions/show_toast_dialog.dart';

// class SignInScreenNew extends StatefulWidget {
//   final bool? isLogin;
//   SignInScreenNew({super.key, this.isLogin});

//   @override
//   State<SignInScreenNew> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreenNew> {
//   TextEditingController phoneController = TextEditingController();
//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//               // image: DecorationImage(
//               //   image: AssetImage(
//               //     "assets/images/login_bg.png",
//               //   ),
//               //   fit: BoxFit.cover,
//               // ),
//               ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 22),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 80,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Image.asset(
//                           "images/bns.png",
//                         ),
//                       ),
//                       SizedBox(
//                         height: 26,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'رمز التحقق',
//                           style: const TextStyle(
//                               letterSpacing: 0.60,
//                               fontSize: 22,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'ادخل رقم الجوال للتحقق من رقم الهاتف',
//                           style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(top: 80),
//                       //   child: Container(
//                       //     decoration: BoxDecoration(
//                       //         border: Border.all(
//                       //           color: ConstantColors.textFieldBoarderColor,
//                       //         ),
//                       //         borderRadius:
//                       //             const BorderRadius.all(Radius.circular(6))),
//                       //     padding: const EdgeInsets.only(left: 10),
//                       //     child: IntlPhoneField(
//                       //       onChanged: (phone) {
//                       //         controller.phoneNumber.value =
//                       //             phone.completeNumber;
//                       //       },
//                       //       invalidNumberMessage: "number invalid",
//                       //       showDropdownIcon: false,
//                       //       disableLengthCheck: true,
//                       //       decoration: InputDecoration(
//                       //         contentPadding:
//                       //             const EdgeInsets.symmetric(vertical: 12),
//                       //         hintText: 'Phone Number'.tr,
//                       //         border: InputBorder.none,
//                       //         isDense: true,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),

//                       SizedBox(
//                         height: 48,
//                       ),
//                       MainTextField(
//                         controller: phoneController,
//                         isShowSuffixIcon: false,
//                         hintText: 'رقم الجوال',
//                         labelText: 'رقم الجوال',
//                         inputType: TextInputType.phone,
//                         onChanged: (phone) {
//                           // controller.phoneNumber.value = phone ?? "";
//                         },
//                       ),
//                       SizedBox(
//                         height: 28,
//                       ),
//                       // Padding(
//                       //     padding: const EdgeInsets.only(top: 50),
//                       //     child: ButtonThem.buildButton(
//                       //       context,
//                       //       title: 'Continue'.tr,
//                       //       btnHeight: 50,
//                       //       btnColor: ConstantColors.primary,
//                       //       txtColor: Colors.white,
//                       //       onPress: () async {
//                       //         FocusScope.of(context).unfocus();
//                       //         if (controller.phoneNumber.value.isNotEmpty) {
//                       //           ShowToastDialog.showLoader("Code sending".tr);
//                       //           controller
//                       //               .sendCode(controller.phoneNumber.value);
//                       //         }
//                       //       },
//                       //     )),
//                       // Container(
//                       //   width: 293,
//                       //   height: 58,
//                       //   decoration: BoxDecoration(
//                       //       color: Colors.white,
//                       //       borderRadius: BorderRadius.circular(6),
//                       //       boxShadow: [
//                       //         BoxShadow(),
//                       //       ]),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       Text(
//                       //         'ارسال رمز التحقق واتساب',
//                       //         style: const TextStyle(
//                       //             letterSpacing: 0.60,
//                       //             fontSize: 14,
//                       //             color: Color(0xff242E42),
//                       //             fontWeight: FontWeight.w900),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 33,
//                       //       ),
//                       //       SvgPicture.asset('images/whatsapp.svg')
//                       //     ],
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 15,
//                       // ),
//                       // Container(
//                       //   width: 293,
//                       //   height: 58,
//                       //   decoration: BoxDecoration(
//                       //       color: Colors.white,
//                       //       borderRadius: BorderRadius.circular(6),
//                       //       boxShadow: [
//                       //         BoxShadow(),
//                       //       ]),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       SizedBox(
//                       //         width: 150,
//                       //         child: Center(
//                       //           child: Text(
//                       //             'ارسال رسالة نصية',
//                       //             style: const TextStyle(
//                       //                 letterSpacing: 0.60,
//                       //                 fontSize: 14,
//                       //                 color: Color(0xff242E42),
//                       //                 fontWeight: FontWeight.w900),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 33,
//                       //       ),
//                       //       Image.asset('images/smss.png')
//                       //     ],
//                       //   ),
//                       // ),

//                       SizedBox(
//                         height: 15,
//                       ),
//                       // Text.rich(
//                       //   TextSpan(
//                       //     text: 'شروط الاستخدام والخصوصية',
//                       //     style: TextStyle(
//                       //       fontSize: 16,
//                       //       color: Colors.white, // Set the text color to white
//                       //       decoration:
//                       //           TextDecoration.underline, // Underline the text
//                       //       decorationColor: Colors
//                       //           .white, // Set the underline color to white
//                       //     ),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       CustomButton(
//                         onTap: () async {
//                           FocusScope.of(context).unfocus();
//                           if (phoneController.text.isNotEmpty) {
//                             launchScreen(
//                                 context,
//                                 OtpScreen(
//                                   phoneNumber: phoneController.text,
//                                 ));
//                             ShowToastDialog.closeLoader();
//                             //  controller.sendCode(controller.phoneNumber.value);
//                           }
//                         },
//                         buttonText: 'التأكيد',
//                         color: Colors.white,
//                       ),
//                       // Padding(
//                       //     padding: const EdgeInsets.only(top: 50),
//                       //     child: ButtonThem.buildButton(
//                       //       context,
//                       //       title: 'Login With Email'.tr,
//                       //       btnHeight: 50,
//                       //       btnColor: ConstantColors.yellow,
//                       //       txtColor: Colors.white,
//                       //       onPress: () {
//                       //         FocusScope.of(context).unfocus();
//                       //         Get.back();
//                       //       },
//                       //     )),
//                     ],
//                   ),
//                 ),
//               ),

//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: GestureDetector(
//               //     onTap: () {
//               //       Get.back();
//               //     },
//               //     child: Container(
//               //         decoration: BoxDecoration(
//               //           borderRadius: BorderRadius.circular(30),
//               //           color: Colors.white,
//               //           boxShadow: <BoxShadow>[
//               //             BoxShadow(
//               //               color: Colors.black.withOpacity(0.3),
//               //               blurRadius: 10,
//               //               offset: const Offset(0, 2),
//               //             ),
//               //           ],
//               //         ),
//               //         child: const Padding(
//               //           padding: EdgeInsets.all(8),
//               //           child: Icon(
//               //             Icons.arrow_back_ios_rounded,
//               //             color: Colors.black,
//               //           ),
//               //         )),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
