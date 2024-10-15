import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Colors.dart';
import 'package:taxi_booking/utils/images.dart';

import '../../../utils/Extensions/app_common.dart';
import '../../../utils/Extensions/custom_button.dart';

class SucessConfirm extends StatelessWidget {
  const SucessConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), //
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.09),
                      Text(
                        'تم الدفع',
                        style: primaryTextStyle(
                          size: 16,
                          color: primaryColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'تم الدفع بنجاح',
                        style: primaryTextStyle(
                          size: 20,
                          color: blackColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'فيزا',
                                    style: primaryTextStyle(
                                      size: 14,
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'ريال749 ',
                                    style: primaryTextStyle(
                                      size: 14,
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'طريقة الدفع',
                                    style: primaryTextStyle(
                                      size: 14,
                                      color: textSecondaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'المجموع ',
                                    style: primaryTextStyle(
                                      size: 14,
                                      color: textSecondaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Column(
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
                            '749 ريال',
                            style: primaryTextStyle(
                              size: 20,
                              color: primaryColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    width: 100,
                    height: 100,
                    image3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              buttonText: 'تصفح طلبي',
              backgroundColor: Colors.white,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SucessConfirm())),
            ),
          ),
        ],
      ),
    );
  }
}
