import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Extensions/theme_helper.dart';

class GetStartAppBar extends StatefulWidget {
  @override
  State<GetStartAppBar> createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<GetStartAppBar> {
  bool _isExpanded = false;

  void _expandContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: _expandContainer,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: _isExpanded ? 360.0 : 60.0,
              height: 60.0,
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
                              Navigator.pushNamed(context, '/page2');
                            },
                          ),
                        ),
                        Text(
                          "EN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "AR",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        'images/global.svg',
                        fit: BoxFit.contain,
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
