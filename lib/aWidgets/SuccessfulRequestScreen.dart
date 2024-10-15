import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

class SuccessfulRequestScreen extends StatefulWidget {
  @override
  _SuccessfulRequestScreenState createState() => _SuccessfulRequestScreenState();
}

class _SuccessfulRequestScreenState extends State<SuccessfulRequestScreen> {
  List<Map<String, String>> requests = [];

  @override
  void initState() {
    super.initState();
    loadBookingData();
  }

  Future<void> loadBookingData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? storedRequests = sharedPref.getStringList('booking_requests');

    if (storedRequests != null) {
      // تحويل كل عنصر من السلسلة إلى خريطة
      requests = storedRequests.map((request) {
        final data = request.split(';'); // استخدام الفاصل الذي اخترته
        return {
          'vehicle_id': data[0],
          'wash_type': data[1],
          'booking_date': data[2],
          'start_address': data[3],
        };
      }).toList();
    }

    // ترتيب الطلبات من الأحدث إلى الأقدم
    requests.sort((a, b) => DateTime.parse(b['booking_date']!).compareTo(DateTime.parse(a['booking_date']!)));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
      appBar: AppBar(title: Text('تاريخ الغـسل' ,  style: TextStyle(color: appTheme.primary  ,fontSize: 18) , ) , backgroundColor: appTheme.secondry,),
      body: requests.isEmpty
          ? Center(child: Text('لا توجد طلبات ناجحة بعد.'))
          : ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: appTheme.secondry,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('رقم السيارة: ${request['vehicle_id']}' , style: TextStyle(color: appTheme.primary),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('نوع الغسل: ${request['wash_type']}' ,  style: TextStyle(color: appTheme.primary)),
                    Text('تاريخ الطلب: ${request['booking_date']}' ,  style: TextStyle(color: appTheme.primary)),
                    Text('العنوان: ${request['start_address']}' ,  style: TextStyle(color: appTheme.primary)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
