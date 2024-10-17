import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/DashBoardScreen.dart';
import '../screens/main_screen/main_screen.dart';
import '../utils/Extensions/theme_helper.dart';

class CustomRowWidget extends StatefulWidget {
  @override
  State<CustomRowWidget> createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<CustomRowWidget> {
  bool _isExpanded = false;

  void _expandContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: _expandContainer,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: _isExpanded ? screenWidth - 60 : 60.0,
                  height:60.0,
                  decoration: BoxDecoration(
                    color: appTheme.secondry,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  alignment: Alignment.center,
                  child: _isExpanded
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'images/global.svg',
                            width: 35,
                            height: 35,
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/page2');
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.local_offer,
                            size: 30,
                            color: appTheme.primary,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoardScreen()),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Image.asset(
                            'images/profile_bar.png',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Image.asset(
                            'images/close_bar.png',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {
                            _expandContainer();
                          },
                        ),
                      ),
                    ],
                  )
                      : Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'images/menu.svg',
                      fit: BoxFit.contain,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _isExpanded ? 0 : 150,
              height: 50, // ارتفاع ثابت
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 150,
                ),
                child: SvgPicture.asset(
                  'images/splash_logo.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),

    );
  }
}