import 'package:flutter/material.dart';

class ExpandableLeftContainerDemo extends StatefulWidget {
  @override
  _ExpandableLeftContainerDemoState createState() =>
      _ExpandableLeftContainerDemoState();
}

class _ExpandableLeftContainerDemoState
    extends State<ExpandableLeftContainerDemo> {
  double _containerWidth = 100.0; // العرض الافتراضي للكونتينر
  bool _isExpanded = false;

  void _expandContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
      _containerWidth =
          _isExpanded ? 300.0 : 100.0; // عرض الكونتينر عند التوسعة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expandable Container from Left"),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0, // تثبيت الكونتينر على يسار الشاشة
            top: 200, // يمكنك تعديل هذه القيمة لتحديد موقعه
            child: GestureDetector(
              onTap: _expandContainer,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300), // مدة الحركة
                width: _containerWidth,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12), // جعل التوسعة على الجانب الأيمن
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Tap to Expand",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExpandableLeftContainerDemo(),
  ));
}

// GestureDetector(
//   onTap: _onIconTap,
//   child: AnimatedContainer(
//     duration: Duration(milliseconds: 500),
//     width: _isExpanded ? 680.h : 127.h,
//     height: 127.h, // احتفظ بالارتفاع ثابتاً
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.horizontal(
//         right: Radius.circular(12),
//       ),
//     ),
//     child: Semantics(
//       label: 'Tap to expand options',
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           SvgPicture.asset(
//             'images/backgroundIcon.svg',
//             fit: BoxFit.fill,
//           ),
//           if (_isExpanded) ...[
//             Positioned(
//               right: 10,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: appTheme.primary,
//                   backgroundColor:
//                       Colors.transparent, // لون النص
//                   shadowColor:
//                       Colors.transparent, // إزالة ظل الزر
//                 ),
//                 onPressed: () {
//                   // Implement AR functionality
//                 },
//                 child: Text('AR'),
//               ),
//             ),
//             Positioned(
//               right: 80,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: appTheme.primary,
//                   backgroundColor:
//                       Colors.transparent, // لون النص
//                   shadowColor:
//                       Colors.transparent, // إزالة ظل الزر
//                 ),
//                 onPressed: () {
//                   // Implement EN functionality
//                 },
//                 child: Text('EN'),
//               ),
//             ),
//           ],
//         ],
//       ),
//     ),
//   ),
// ),
