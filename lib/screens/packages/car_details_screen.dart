import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/packages/widgets/car_details_body.dart';

import '../../utils/Colors.dart';
import '../../utils/Extensions/app_common.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({Key? key, required this.packageId}) : super(key: key);
  final int packageId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل السيارة',
            style: boldTextStyle(color: appTextPrimaryColorWhite)),
      ),
      body: CarDetailsBody(packageId: packageId),
    );
  }
}
