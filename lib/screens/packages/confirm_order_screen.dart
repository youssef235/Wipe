import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/packages/widgets/confirm_order_body.dart';

import '../../model/CarDetailsModel.dart';
import '../../utils/Colors.dart';
import '../../utils/Extensions/app_common.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key? key, required this.carDetailsModel})
      : super(key: key);
  final CarDetailsModel carDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تأكيد الطلب',
            style: boldTextStyle(color: appTextPrimaryColorWhite)),
      ),
      body: ConfirmOrderBody(carDetailsModel: carDetailsModel),
    );
  }
}
