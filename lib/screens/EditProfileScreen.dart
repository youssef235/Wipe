import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../../utils/Common.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/app_textfield.dart';
import '../aWidgets/upper_app_bar.dart';
import '../components/drawer_component.dart';
import '../network/RestApis.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/StringExtensions.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/theme_helper.dart';

class EditProfileScreen extends StatefulWidget {
  final bool? isGoogle;

  EditProfileScreen({this.isGoogle = false});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageProfile;
  String countryCode = defaultCountryCode;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode firstnameFocus = FocusNode();
  FocusNode lastnameFocus = FocusNode();
  FocusNode contactFocus = FocusNode();
  FocusNode addressFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    appStore.setLoading(true);
    print( "IDDDDDDDDD ${sharedPref.getInt(USER_ID)}");
    getUserDetail(userId: sharedPref.getInt(USER_ID)).then((value) {
      emailController.text = value.data!.email.validate();
      usernameController.text = value.data!.username.validate();
      firstNameController.text = value.data!.firstName.validate();
      lastNameController.text = value.data!.lastName.validate();
      addressController.text = value.data!.address.validate();
      contactNumberController.text = value.data!.contactNumber.validate();

      appStore.setLoading(false);
      setState(() {});
    }).catchError((error) {
      log(error.toString());
      appStore.setLoading(false);
    });
  }

  Widget profileImage() {
    return Center();
  }

  Future<void> saveProfile() async {
    hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      appStore.setLoading(true);

      String currentTime = DateTime.now().toIso8601String().replaceAll(':', '_').replaceAll('.', '_');
      String generatedEmail = '$currentTime@gmail.com';
      String generatedUsername = '$currentTime';

      await updateProfile(
        uid: sharedPref.getString(UID),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        userEmail: generatedEmail,
        contactNumber: contactNumberController.text.trim(),
        address: addressController.text.trim(),
        username: generatedUsername, // قيمة ثابتة لاسم المستخدم
        password: "12345678", // كلمة مرور صالحة
        file: imageProfile != null ? File(imageProfile!.path.validate()) : null,
      ).then((value) {
        appStore.setLoading(false);
        toast(language.profileUpdateMsg);
        Navigator.pop(context);
      }).catchError((error) {
        appStore.setLoading(false);
        log(error.toString());
        toast(language.updateProfile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary, // الخلفية بلون theme.primary

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  CustomRowWidget(),
                  SizedBox(height: 50),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: firstNameController,
                    textFieldType: TextFieldType.NAME,
                    focus: firstnameFocus,
                    nextFocus: lastnameFocus,
                    decoration: InputDecoration(
                      labelText: language.firstName,
                      labelStyle: TextStyle(fontSize: 14), // تصغير حجم النص
                      suffixIcon: Icon(Icons.person, color: appTheme.secondry),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                    ),
                    errorThisFieldRequired: language.thisFieldRequired,
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: lastNameController,
                    textFieldType: TextFieldType.NAME,
                    focus: lastnameFocus,
                    nextFocus: contactFocus,
                    decoration: InputDecoration(
                      labelText: language.lastName,
                      labelStyle: TextStyle(fontSize: 14), // تصغير حجم النص
                      suffixIcon: Icon(Icons.person, color: appTheme.secondry),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                    ),
                    errorThisFieldRequired: language.thisFieldRequired,
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: contactNumberController,
                    textFieldType: TextFieldType.PHONE,
                    focus: contactFocus,
                    nextFocus: addressFocus,
                    decoration: InputDecoration(
                      labelText: language.phoneNumber,
                      labelStyle: TextStyle(fontSize: 14), // تصغير حجم النص
                      suffixIcon: Icon(Icons.phone, color: appTheme.secondry),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: addressController,
                    focus: addressFocus,
                    textFieldType: TextFieldType.ADDRESS,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: language.address,
                      labelStyle: TextStyle(fontSize: 14), // تصغير حجم النص
                      suffixIcon: Icon(Icons.home, color: appTheme.secondry),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide:
                            BorderSide(color: appTheme.black90001, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: appStore.isLoading,
                child: loaderWidget(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButtonWidget(
          text: language.updateProfile,
          textStyle: boldTextStyle(color: Colors.white),
          color: appTheme.secondry, // لون الزر بلون theme.secondary
          elevation: 5,
          onTap: saveProfile,
        ),
      ),
    );
  }
}
