import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../main_screen/main_screen.dart';

class RatingResultScreen extends StatelessWidget {
  final int rating;

  RatingResultScreen({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary, // لون الخلفية
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRowWidget(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Container(
                width: 350,
                height: 400,
                decoration: BoxDecoration(
                  color: appTheme.secondry, // لون الكارد
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'شكرا لك على التـقييـم',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: appTheme.primary,
                          size: 40,
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'نتمنى ان نكون دائما عند حسن ظنكم',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize:
                MainAxisSize.min, // جعل عرض الـ Row يتناسب مع محتوياته
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Confirmbutton(
                    textColor: appTheme.secondry,
                    color: appTheme.primary,
                    text: "العودة إلى الصفحة الرئيسية",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class Confirmbutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  Confirmbutton({
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: appTheme.secondry),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
