import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/packages/widgets/sucess_confirm.dart';
import 'package:taxi_booking/utils/Extensions/app_common.dart';
import 'package:taxi_booking/utils/images.dart';

import '../../../main.dart';
import '../../../model/CarDetailsModel.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Extensions/custom_button.dart';
import '../../NewEstimateRideListWidget.dart';
import '../confirm_order_screen.dart';

class ConfirmOrderBody extends StatelessWidget {
  const ConfirmOrderBody({Key? key, required this.carDetailsModel})
      : super(key: key);
  final CarDetailsModel carDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'بطاقة بنكية',
            style: primaryTextStyle(
              size: 16,
              color: blackColor,
              weight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                width: 32,
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    '************2575',
                    style: primaryTextStyle(
                      color: blackColor,
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    image1,
                    width: 32,
                    height: 30,
                  ),
                  Radio(
                    value: 1,
                    groupValue: 0,
                    onChanged: (val) {},
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'الدفع عند الاستلام',
            style: primaryTextStyle(
              size: 16,
              color: blackColor,
              weight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image2,
                width: 32,
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    'الدفع عند الاستلام',
                    style: primaryTextStyle(
                      size: 16,
                      color: blackColor,
                      weight: FontWeight.w700,
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (val) {},
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: textSecondaryColor,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 17,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'طريقة الدفع',
                              style: primaryTextStyle(
                                size: 16,
                                color: textSecondaryColor,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Row(
                          children: [
                            Text(
                              'المجموع',
                              style: primaryTextStyle(
                                size: 16,
                                color: textSecondaryColor,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 17,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '',
                              style: primaryTextStyle(
                                size: 16,
                                color: textSecondaryColor,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Row(
                          children: [
                            Text(
                              '${carDetailsModel.cost} ريال',
                              style: primaryTextStyle(
                                size: 16,
                                color: textSecondaryColor,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: textSecondaryColor,
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'المبلغ المدفوع',
                  style: primaryTextStyle(
                    size: 14,
                    color: textSecondaryColor,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${carDetailsModel.cost} ريال',
                  style: primaryTextStyle(
                    size: 20,
                    color: primaryColor,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 33,
          ),
          CustomButton(
            buttonText: 'الاستمرار',
            backgroundColor: Colors.white,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SucessConfirm())),
          ),
        ],
      ),
    );
  }
}
