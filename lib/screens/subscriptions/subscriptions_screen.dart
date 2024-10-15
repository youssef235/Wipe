import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/Extensions/app_common.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('الاشتراكات',
          style: boldTextStyle(color: appTextPrimaryColorWhite)),
    ));
  }
}
