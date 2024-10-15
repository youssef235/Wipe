import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_booking/utils/Extensions/StringExtensions.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../main.dart';
import '../../network/RestApis.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/app_common.dart';
import '../status_screens/status_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';


class CheckoutScreen extends StatefulWidget {
  final int selectedCarId;
  final String selectedWashType;
  final DateTime selectedDate;

  final int serviceId;

  final int washPrice;

  CheckoutScreen({
    required this.selectedCarId,
    required this.selectedWashType,
    required this.selectedDate,
    required this.serviceId,

    required this.washPrice,

  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double? latitude;
  double? longitude;
  String? locationName;
  String? contactNumber;

  @override
  void initState() {
    super.initState();
    _loadLocation();
    appStore.setLoading(true);
    getUserDetail(userId: sharedPref.getInt(USER_ID)).then((value) {
      contactNumber = value.data!.contactNumber?.validate();

      appStore.setLoading(false);
      setState(() {});
    }).catchError((error) {
      log(error.toString());
      appStore.setLoading(false);
    });
  }

  Future<void> _loadLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
    });

    if (latitude != null && longitude != null) {
      // تحويل الإحداثيات إلى اسم الموقع
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude!, longitude!);
      Placemark place = placemarks[0];
      setState(() {
        locationName = "${place.street ?? ''}, ${place.locality ?? ''}";

        locationName = locationName?.replaceAll(RegExp(r', $'), '');
      });
    }
  }



  Future<void> saveBookingData() async {
    if (contactNumber == null || contactNumber!.isEmpty) {
      return toast('رقم الاتصال مطلوب');
    }

    appStore.setLoading(true);

    Map<String, dynamic> req = {
      "rider_id": sharedPref.getInt(USER_ID).toString(),
      "service_id": widget.serviceId,
      "vehicle_id": widget.selectedCarId.toString(),
      "datetime": DateTime.now().toString(),
      "start_latitude": latitude.toString(),
      "start_longitude": longitude.toString(),
      "start_address": locationName,
      "riderequest_in_datetime": DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.selectedDate),
      "seat_count": '1',
      "status": 'NEW_RIDE_REQUESTED',
      "payment_type": 'cash',
    };

    log('Request Data: $req');

    await saveRideRequest(req).then((value) async {
      print("DONNNEE");
      toast('تم إرسال الطلب بنجاح');

      // حفظ الطلب كخريطة
      String requestToStore = "${widget.selectedCarId};${widget.selectedWashType};${DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.selectedDate)};${locationName}";

      // استرجاع الطلبات المخزنة
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      List<String>? storedRequests = sharedPref.getStringList('booking_requests') ?? [];

      // إضافة الطلب الجديد
      storedRequests.add(requestToStore);

      // حفظ الطلبات مرة أخرى
      await sharedPref.setStringList('booking_requests', storedRequests);

      appStore.setLoading(false);
    }).catchError((error) {
      log('Error: $error');
      toast('حدث خطأ أثناء إرسال الطلب');
      appStore.setLoading(false);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              CustomRowWidget(),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'الـدفــع',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: appTheme.secondry,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appTheme.secondry, // لون الخلفية الداخلية
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'السيارة : ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.selectedCarId}',
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الخدمة :',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.selectedWashType}',
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (latitude != null && longitude != null) ...[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // جعل العناصر تبدأ من اليسار
                        children: [
                          Text(
                            'الموقع : ',
                            // عرض اسم الموقع
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 8), // إضافة مسافة بين النصين
                          Expanded(
                            child: Text(
                              '$locationName',
                          //    textDirection: TextDirection.ltr,

                              // عرض اسم الموقع
                              style: TextStyle(fontSize: 10),
                              maxLines: 2, // تحديد أن النص يظهر على سطرين
                              overflow: TextOverflow
                                  .ellipsis, // إذا كان النص أطول من سطرين، يظهر علامة "..."
                              softWrap: true, // السماح بلف النص إذا كان طويلاً
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      SizedBox(height: 10),
                      Text(
                        'Location not available',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'جهة الإتصال:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$contactNumber',
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.selectedWashType}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          " ${widget.washPrice.toString()} ريال سعودي ",
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Mats Covering (2 Pcs)',
                    //       style: TextStyle(fontSize: 16, color: Colors.white),
                    //     ),
                    //     Text(
                    //       ' 8 ريال سعودي',
                    //       style:
                    //           TextStyle(fontSize: 16, color: appTheme.primary),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20),
                    Divider(color: Colors.white),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'التكلفة الإجمالية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " ${widget.washPrice.toString()} ريال سعودي ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: appTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'الدفع عن الإستلام',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: appTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: PaymentButton(
                      text: 'إستمرار',
                      color: appTheme.secondry,
                      textColor: appTheme.primary,
                      onTap: (){
                        saveBookingData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusScreen(
// التاريخ المختار
                            ),
                          ),
                        );
                      }, // استدعاء دالة حفظ البيانات عند الضغط

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class PaymentButton extends StatelessWidget {
final String text;
final Color color;
final Color textColor;
final VoidCallback onTap;

PaymentButton({
required this.text,
required this.color,
required this.textColor,
required this.onTap,
});

@override
Widget build(BuildContext context) {
return InkWell(
onTap: onTap,
child: Container(
width: 120,
height: 50,
decoration: BoxDecoration(
color: color,
borderRadius: BorderRadius.circular(30),
border: Border.all(color: textColor),
),
child: Center(
child: Text(
text,
style: TextStyle(
color: textColor,
fontSize: 16,
),
),
),
),
);
}
}