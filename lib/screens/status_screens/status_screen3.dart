import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../components/drawer_component.dart';
import 'RatingResultScreen.dart';

class StatusScreen3 extends StatefulWidget {
  const StatusScreen3({super.key});

  @override
  State<StatusScreen3> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen3> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.primary,
      drawer: DrawerComponent(),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: context.statusBarHeight + 4,
                  ),
                  CustomRowWidget(),
                  SizedBox(
                    height: 120.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'تم تنظيف سيارتك بنجاح',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 596.h,
                      child: Text(
                        'تمـت عملية غسيل سيارتك',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: appTheme.secondry,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.v,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 5.h,
                          width: 600.h,
                          decoration: BoxDecoration(
                            color: appTheme.secondry,
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          left: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.secondry,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 140.h,
                                child: Text(
                                  'الغسل تم جدولته',
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          right: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.secondry,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 140.h,
                                child: Text(
                                  'تمت عملية الغسل',
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -22.5.h,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: appTheme.secondry),
                                    color: appTheme.secondry,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: 20.v,
                              ),
                              SizedBox(
                                width: 160.h,
                                child: Text(
                                  'بدأت عملية الغسل',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: appTheme.secondry,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0, // ضبط الكارد ليكون في الأسفل
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity, // عرض كامل
              padding: EdgeInsets.symmetric(
                  horizontal: 15), // حواف من اليمين والشمال
              child: InkWell(
                onTap: () {
                  // هنا يمكنك إضافة أي عمل تريده عند الضغط على الكارد
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Container(
                    height: 250, // ارتفاع الكارد
                    decoration: BoxDecoration(
                      color: appTheme
                          .secondry, // تغيير لون الخلفية ليكون مطابقاً للصورة
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      // استخدام عمود لترتيب النصوص
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'قيم غسيل سيارتك!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // مسافة بين النصوص
                        Text(
                          'يرجى تقييم أخصائي غسيل السيارات لدينا لمساعدتنا في ضمان',
                          textAlign:
                              TextAlign.center, // محاذاة النص إلى المنتصف
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'أفضل خدمة.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10), // مسافة إضافية بين النصوص
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  rating = index + 1; // تحديث التقييم
                                });
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      index < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: index < rating
                                          ? appTheme.primary
                                          : Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Confirmbutton(
                          color: appTheme.primary,
                          text: 'تأكـيد',
                          textColor: appTheme.secondry,
                          rating: rating,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Confirmbutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final int rating;

  Confirmbutton({
    required this.text,
    required this.color,
    required this.textColor,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RatingResultScreen(rating: rating),
          ),
        );
      },
      child: Container(
        width: 80,
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
