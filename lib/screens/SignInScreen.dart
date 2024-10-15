import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';

import '../../components/OTPDialog.dart';
import '../../main.dart';
import '../../network/RestApis.dart';
import '../../screens/ForgotPasswordScreen.dart';
import '../../service/AuthService1.dart';
import '../../utils/Colors.dart';
import '../../utils/Common.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/AppButtonWidget.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/app_textfield.dart';
import '../model/LoginResponse.dart';
import '../service/AuthService.dart';
import '../utils/Extensions/StringExtensions.dart';
import '../utils/Extensions/context_extension.dart';
import '../utils/images.dart';
import 'DashBoardScreen.dart';
import 'SignUpScreen.dart';
import 'TermsConditionScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthServices authService = AuthServices();
  GoogleAuthServices googleAuthService = GoogleAuthServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  bool mIsCheck = false;
  bool isAcceptedTc = false;
  String? privacyPolicy;
  String? termsCondition;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    appSetting();
    await saveOneSignalPlayerId().then((value) {});
    mIsCheck = sharedPref.getBool(REMEMBER_ME) ?? false;
    if (mIsCheck) {
      emailController.text = sharedPref.getString(USER_EMAIL).validate();
      passController.text = sharedPref.getString(USER_PASSWORD).validate();
    }
  }

  Future<void> logIn() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isAcceptedTc) {
        appStore.setLoading(true);

        Map req = {
          'contact_number': emailController.text.trim(),
          'password': passController.text.trim(),
          "player_id": sharedPref.getString(PLAYER_ID).validate(),
          'user_type': RIDER,
        };
        log(req);
        await logInApi(req).then((value) {
          userModel = value.data!;

          auth
              .signInWithEmailAndPassword(
                  email: emailController.text, password: passController.text)
              .then((value) async {
            sharedPref.setString(UID, value.user!.uid);
            updateProfileUid();
            appStore.setLoading(false);
            await checkPermission().then((value) async {
              await Geolocator.getCurrentPosition().then((value) {
                sharedPref.setDouble(LATITUDE, value.latitude);
                sharedPref.setDouble(LONGITUDE, value.longitude);
              });
            });
            launchScreen(context, DashBoardScreen(),
                isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
          }).catchError((e) {
            if (e.toString().contains('user-not-found')) {
              authService.signUpWithEmailPassword(
                context,
                mobileNumber: userModel.contactNumber,
                email: userModel.email,
                fName: userModel.firstName,
                lName: userModel.lastName,
                userName: userModel.username,
                password: passController.text,
                userType: RIDER,
              );
            } else {
              launchScreen(context, DashBoardScreen(),
                  isNewTask: true,
                  pageRouteAnimation: PageRouteAnimation.Slide);
            }
            log(e.toString());
          });
          appStore.setLoading(false);
        }).catchError((error) {
          appStore.isLoading = false;
          toast(error.toString());
        });
      } else {
        toast(language.pleaseAcceptTermsOfServicePrivacyPolicy);
      }
    }
  }

  Future<void> appSetting() async {
    await getAppSettingApi().then((value) {
      if (value.privacyPolicyModel!.value != null)
        privacyPolicy = value.privacyPolicyModel!.value;
      if (value.termsCondition!.value != null)
        termsCondition = value.termsCondition!.value;
    }).catchError((error) {
      log(error.toString());
    });
  }

  void googleSignIn() async {
    hideKeyboard(context);
    appStore.setLoading(true);

    await googleAuthService.signInWithGoogle(context).then((value) async {
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
      print(e.toString());
    });
  }

  appleLoginApi() async {
    hideKeyboard(context);
    appStore.setLoading(true);
    await appleLogIn().then((value) {
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4CC3E5),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.statusBarHeight + 16),
                  ClipRRect(
                      borderRadius: radius(50),
                      child: Image.asset(ic_app_logo, width: 100, height: 100)),
                  SizedBox(height: 16),
                  Text(language.welcome, style: boldTextStyle(size: 22)),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '${language.signContinue} ',
                            style: primaryTextStyle(size: 14)),
                        TextSpan(text: '🚗', style: primaryTextStyle(size: 20)),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  AppTextField(
                    controller: emailController,
                    nextFocus: passFocus,
                    autoFocus: false,
                    textFieldType: TextFieldType.PHONE,
                    keyboardType: TextInputType.number,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration:
                        inputDecoration(context, label: language.phoneNumber),
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: passController,
                    focus: passFocus,
                    autoFocus: false,
                    textFieldType: TextFieldType.PASSWORD,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration:
                        inputDecoration(context, label: language.password),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: Color(0xff201B51),
                              value: mIsCheck,
                              shape: RoundedRectangleBorder(
                                  borderRadius: radius(4)),
                              onChanged: (v) async {
                                mIsCheck = v!;
                                if (!mIsCheck) {
                                  sharedPref.remove(REMEMBER_ME);
                                } else {
                                  await sharedPref.setBool(
                                      REMEMBER_ME, mIsCheck);
                                  await sharedPref.setString(
                                      USER_EMAIL, emailController.text);
                                  await sharedPref.setString(
                                      USER_PASSWORD, passController.text);
                                }

                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          inkWellWidget(
                            onTap: () async {
                              mIsCheck = !mIsCheck;
                              setState(() {});
                            },
                            child: Text(language.rememberMe,
                                style: primaryTextStyle(size: 14)),
                          ),
                        ],
                      ),
                      inkWellWidget(
                        onTap: () {
                          launchScreen(context, ForgotPasswordScreen(),
                              pageRouteAnimation:
                                  PageRouteAnimation.SlideBottomTop);
                        },
                        child: Text(language.forgotPassword,
                            style: primaryTextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: Color(0xff201B51),
                          value: isAcceptedTc,
                          shape:
                              RoundedRectangleBorder(borderRadius: radius(4)),
                          onChanged: (v) async {
                            isAcceptedTc = v!;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: language.iAgreeToThe + " ",
                                  style: primaryTextStyle(size: 12)),
                              TextSpan(
                                text:
                                    language.termsConditions.splitBefore(' &'),
                                style: boldTextStyle(
                                    color: primaryColor, size: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (termsCondition != null &&
                                        termsCondition!.isNotEmpty) {
                                      launchScreen(
                                          context,
                                          TermsConditionScreen(
                                              title: language.termsConditions,
                                              subtitle: termsCondition),
                                          pageRouteAnimation:
                                              PageRouteAnimation.Slide);
                                    } else {
                                      toast(language.txtURLEmpty);
                                    }
                                  },
                              ),
                              TextSpan(
                                  text: ' & ',
                                  style: primaryTextStyle(size: 12)),
                              TextSpan(
                                text: language.privacyPolicy,
                                style: boldTextStyle(
                                    color: Color(0xff201B51), size: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (privacyPolicy != null &&
                                        privacyPolicy!.isNotEmpty) {
                                      launchScreen(
                                          context,
                                          TermsConditionScreen(
                                              title: language.privacyPolicy,
                                              subtitle: privacyPolicy),
                                          pageRouteAnimation:
                                              PageRouteAnimation.Slide);
                                    } else {
                                      toast(language.txtURLEmpty);
                                    }
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  AppButtonWidget(
                    color: Color(0xff201B51),
                    width: MediaQuery.of(context).size.width,
                    text: language.logIn,
                    onTap: () async {
                      logIn();
                    },
                  ),
                  SizedBox(height: 16),
                  socialWidget(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: appStore.isLoading,
                child: loaderWidget(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(language.donHaveAnAccount, style: primaryTextStyle()),
                SizedBox(width: 8),
                inkWellWidget(
                  onTap: () {
                    hideKeyboard(context);
                    launchScreen(
                        context,
                        SignUpScreen(
                            privacyPolicyUrl: privacyPolicy,
                            termsConditionUrl: termsCondition));
                  },
                  child: Text(language.signUp, style: boldTextStyle()),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget socialWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: Divider(color: dividerColor)),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(language.orLogInWith, style: primaryTextStyle()),
              ),
              Expanded(child: Divider(color: dividerColor)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inkWellWidget(
              onTap: () async {
                googleSignIn();
              },
              child: socialWidgetComponent(img: ic_google),
            ),
            SizedBox(width: 12),
            inkWellWidget(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(16),
                      content: OTPDialog(),
                    );
                  },
                );
                appStore.setLoading(false);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: dividerColor),
                    borderRadius: radius(defaultRadius)),
                child: Image.asset(ic_mobile,
                    fit: BoxFit.cover, height: 30, width: 30),
              ),
            ),
            if (Platform.isIOS) SizedBox(width: 12),
            if (Platform.isIOS)
              inkWellWidget(
                onTap: () async {
                  appleLoginApi();
                },
                child: socialWidgetComponent(img: ic_apple),
              ),
          ],
        ),
      ],
    );
  }

  Widget socialWidgetComponent({required String img}) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: dividerColor),
          borderRadius: radius(defaultRadius)),
      child: Image.asset(img, fit: BoxFit.cover, height: 30, width: 30),
    );
  }
}
