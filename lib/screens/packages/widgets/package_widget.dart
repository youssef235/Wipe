import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/packages_model.dart';
import '../../../network/RestApis.dart';
import '../../../utils/Extensions/app_common.dart';
import '../car_details_screen.dart';

class PackageWidget extends StatelessWidget {
  const PackageWidget({super.key, required this.model});

  final PackagesDatum model;

  Future _subscripeOnTap(BuildContext context) async {
    appStore.setLoading(true);
    await subscripe(packageId: model.id).then((value) async {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CarDetailsScreen(packageId: value)));
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    model.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'غسيل ${model.orderTimes} فلاسبوع',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.price} ريال شهريا',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => _subscripeOnTap(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 5),

                    backgroundColor: Color(0xff19457B), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'الاشتراك',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
