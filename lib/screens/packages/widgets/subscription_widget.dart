import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../main.dart';
import '../../../model/packages_model.dart';
import '../../../network/RestApis.dart';
import '../../../utils/Extensions/app_common.dart';
import '../../DashBoardScreen.dart';
import '../../NewEstimateRideListWidget.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({super.key, required this.model});

  final Subscripe model;

  Future _renewSubscripeOnTap(BuildContext context, int subscripeId) async {
    appStore.setLoading(true);
    await renewSubscripe(subscripeId: subscripeId).then((value) async {
      toast(value.message);
      launchScreen(context, DashBoardScreen(), isNewTask: true);
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          launchScreen(
              context,
              NewEstimateRideListWidget(
                sourceLatLog: polylineSource,
                destinationLatLog: polylineDestination,
                sourceTitle: appStore.selectedStartAddress ?? "",
                destinationTitle: appStore.selectedStartAddress ?? "",
                vehicle_id: model.id,
              ),
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color
                  spreadRadius: 0, // Spread radius
                  blurRadius: 4, // Blur radius
                  offset: Offset(0, 4), // Offset in x and y direction
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اشتراكي ${model.vehicle?.manufacturerName ?? ""}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'غسيل ${model.orderTimes} فلاسبوع',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${model.package.price} ريال شهريا',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                _btnWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnWidget(BuildContext context) {
    Duration expireDate = model.expireAt.difference(DateTime.now());
    if (model.package.orderTimes == model.package.periods) {
      return SizedBox.shrink();
    } else if (expireDate == Duration.zero) {
      return SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: () async => await _renewSubscripeOnTap(context, model.id),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5),

            backgroundColor: Color(0xff37BC5C), // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
            ),
          ),
          child: Text(
            'تجديد',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 30,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.red, // Background color
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            'ينتهي في ${DateFormat('dd/MM/yy').format(model.expireAt)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
