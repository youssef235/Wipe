import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

class LanguageAppBar extends StatefulWidget {
  @override
  _CustomRowWidgetState createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<LanguageAppBar> {
  bool _isExpanded = false;

  void _expandContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'images/splash_logo.svg',
              fit: BoxFit.fill,
              width: 100,
              height: 30,
            ),
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: GestureDetector(
            onTap: _expandContainer,
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _isExpanded ? 200.0 : 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: appTheme.secondry, // استبدل هذا بلون ثيم التطبيق
                  borderRadius: BorderRadius.circular(50.0),
                ),
                alignment: Alignment.center,
                child: _isExpanded
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          // تنفيذ وظيفة AR
                        },
                        child: Text('AR'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          // تنفيذ وظيفة EN
                        },
                        child: Text('EN'),
                      ),
                    ),
                  ],
                )
                    : SvgPicture.asset(
                  'images/global.svg',
                  fit: BoxFit.fill,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
