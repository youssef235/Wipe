import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../utils/Common.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../model/SettingModel.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/LiveStream.dart';
import '../utils/Extensions/app_common.dart';
import 'AboutScreen.dart';
import 'ChangePasswordScreen.dart';
import 'DeleteAccountScreen.dart';
import 'LanguageScreen.dart';
import 'TermsConditionScreen.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  SettingModel settingModel = SettingModel();
  String? privacyPolicy;
  String? termsCondition;
  String? mHelpAndSupport;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    LiveStream().on(CHANGE_LANGUAGE, (p0) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.settings,
            style: boldTextStyle(color: appTextPrimaryColorWhite)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16, top: 16),
        child: Column(
          children: [
            Visibility(
              visible: sharedPref.getString(LOGIN_TYPE) != 'mobile' &&
                  sharedPref.getString(LOGIN_TYPE) != LoginTypeGoogle &&
                  sharedPref.getString(LOGIN_TYPE) != null,
              child: settingItemWidget(
                  Ionicons.ios_lock_closed_outline, language.changePassword,
                  () {
                launchScreen(context, ChangePasswordScreen(),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              }),
            ),
            settingItemWidget(Ionicons.language_outline, language.language, () {
              launchScreen(context, LanguageScreen(),
                  pageRouteAnimation: PageRouteAnimation.Slide);
            }),
            if (appStore.privacyPolicy != null)
              settingItemWidget(
                  Ionicons.ios_document_outline, language.privacyPolicy, () {
                launchScreen(
                    context,
                    TermsConditionScreen(
                        title: language.privacyPolicy,
                        subtitle: appStore.privacyPolicy),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              }),
            if (appStore.mHelpAndSupport != null)
              settingItemWidget(Ionicons.help_outline, language.helpSupport,
                  () {
                if (mHelpAndSupport != null) {
                  launchUrl(Uri.parse(appStore.mHelpAndSupport!));
                } else {
                  toast(language.txtURLEmpty);
                }
              }),
            if (appStore.termsCondition != null)
              settingItemWidget(
                  Ionicons.document_outline, language.termsConditions, () {
                if (appStore.termsCondition != null) {
                  launchScreen(
                      context,
                      TermsConditionScreen(
                          title: language.termsConditions,
                          subtitle: appStore.termsCondition),
                      pageRouteAnimation: PageRouteAnimation.Slide);
                } else {
                  toast(language.txtURLEmpty);
                }
              }),
            settingItemWidget(
              Ionicons.information,
              language.aboutUs,
              () {
                launchScreen(
                    context, AboutScreen(settingModel: appStore.settingModel),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            settingItemWidget(
                Ionicons.ios_trash_outline, language.deleteAccount, () {
              launchScreen(context, DeleteAccountScreen(),
                  pageRouteAnimation: PageRouteAnimation.Slide);
            }, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget settingItemWidget(IconData icon, String title, Function() onTap,
      {bool isLast = false, Widget? suffixIcon}) {
    return inkWellWidget(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 8),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(color: dividerColor),
                  borderRadius: radius(defaultRadius)),
              child: Icon(icon, size: 20, color: primaryColor),
            ),
            SizedBox(width: 12),
            Expanded(child: Text(title, style: primaryTextStyle())),
            suffixIcon != null
                ? suffixIcon
                : Icon(Icons.navigate_next, color: dividerColor),
          ],
        ),
      ),
    );
  }
}
