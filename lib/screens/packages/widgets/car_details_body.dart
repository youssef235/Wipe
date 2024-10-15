import 'package:flutter/material.dart';
import 'package:taxi_booking/network/RestApis.dart';

import '../../../main.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Extensions/app_common.dart';
import '../../../utils/Extensions/custom_button.dart';
import '../../../utils/Extensions/custom_text_field.dart';
import '../../NewEstimateRideListWidget.dart';
import '../confirm_order_screen.dart';

class CarDetailsBody extends StatelessWidget {
  CarDetailsBody({Key? key, required this.packageId}) : super(key: key);
  final int packageId;
  final companyNameController = TextEditingController();
  final carTypeController = TextEditingController();
  final carColorController = TextEditingController();
  final carNumController = TextEditingController();

  _addCar(BuildContext context) {
    addCar(
      packageId: packageId,
      companyName: companyNameController.text,
      type: carTypeController.text,
      color: carColorController.text,
      carNum: carNumController.text,
    ).then((value) {
      launchScreen(
          context,
          NewEstimateRideListWidget(
            sourceLatLog: polylineSource,
            destinationLatLog: polylineDestination,
            sourceTitle: appStore.selectedStartAddress ?? "",
            destinationTitle: appStore.selectedStartAddress ?? "",
            vehicle_id: packageId,
          ),
          pageRouteAnimation: PageRouteAnimation.SlideBottomTop);

      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ConfirmOrderScreen(carDetailsModel: value)));
    }).catchError((e) {
      toast(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _columnWidget(
            text: 'اسم شركة السيارة',
            subText: 'اختيار الشركة المصنعة للسيارة',
            textField: MainTextField(
              controller: companyNameController,
              isShowSuffixIcon: false,
              textColor: primaryColor,
              inputType: TextInputType.text,
              onChanged: (text) {
                companyNameController.text = text ?? '';
              },
            ),
          ),
          _columnWidget(
            text: 'نوع السيارة',
            subText: 'اختيار نوع للسيارة',
            textField: MainTextField(
              controller: carTypeController,
              isShowSuffixIcon: false,
              textColor: primaryColor,
              inputType: TextInputType.text,
              onChanged: (text) {
                carTypeController.text = text ?? '';
              },
            ),
          ),
          _columnWidget(
            text: 'اللون',
            subText: 'اختيار لون السيارة',
            textField: MainTextField(
              controller: carColorController,
              isShowSuffixIcon: false,
              textColor: primaryColor,
              inputType: TextInputType.text,
              onChanged: (text) {
                carColorController.text = text ?? '';
              },
            ),
          ),
          _columnWidget(
            text: 'اللوحة',
            subText: 'كتابة لوحة السيارة',
            textField: MainTextField(
              controller: carNumController,
              isShowSuffixIcon: false,
              textColor: primaryColor,
              inputType: TextInputType.text,
              onChanged: (text) {
                carNumController.text = text ?? '';
              },
            ),
          ),
          CustomButton(
            buttonText: 'الاستمرار',
            backgroundColor: Colors.white,
            onTap: () async => await _addCar(context),
          ),
        ],
      ),
    );
  }

  Widget _columnWidget(
      {required String text,
      required String subText,
      required Widget textField}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: primaryTextStyle(
                color: scaffoldColorDark, weight: FontWeight.w500, size: 16),
          ),
          Text(
            subText,
            style: primaryTextStyle(
                color: textSecondaryColor, weight: FontWeight.w400, size: 14),
          ),
          textField,
        ],
      ),
    );
  }
}
