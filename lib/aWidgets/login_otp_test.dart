// import 'package:flutter/material.dart';
// import 'package:taxi_booking/service/firebase_otp_service.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   String? _verificationId;
//   final PhoneAuthService _phoneAuthService = PhoneAuthService();
//   bool _isLoading = false; // متغير لتحميل حالة
//
//   final String _phoneNumber =
//       "+201080793193"; // أدخل الرقم الذي تريد إرسال OTP إليه
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login with Phone'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await _phoneAuthService.verifyPhoneNumber(
//                       _phoneNumber,
//                       (verificationId) {
//                         setState(() {
//                           _verificationId = verificationId;
//                           _isLoading = false;
//                         });
//                       },
//                     );
//                   } catch (error) {
//                     setState(() {
//                       _isLoading = false;
//                     });
//                     // عرض رسالة خطأ أكثر وضوحًا للمستخدم
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to send OTP: $error')),
//                     );
//                   }
//                 },
//                 child: _isLoading
//                     ? CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       )
//                     : Text('Send OTP to $_phoneNumber'),
//               ),
//             ),
//             SizedBox(height: 16),
//             if (_verificationId != null) ...[
//               TextField(
//                 controller: _otpController,
//                 decoration: InputDecoration(labelText: 'Enter OTP'),
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // التحقق من OTP المدخل
//                     setState(() {
//                       _isLoading = true; // بدأ التحميل عند محاولة التحقق
//                     });
//                     try {
//                       await _phoneAuthService.signInWithOtp(
//                         _verificationId!,
//                         _otpController.text,
//                       );
//                       // يمكنك هنا توجيه المستخدم لصفحة أخرى بعد تسجيل الدخول
//                     } catch (error) {
//                       // تظهر رسالة خطأ في حالة الفشل
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error: $error')),
//                       );
//                     } finally {
//                       setState(() {
//                         _isLoading = false; // أنهى التحميل
//                       });
//                     }
//                   },
//                   child: _isLoading
//                       ? CircularProgressIndicator(
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                         )
//                       : Text('Verify OTP'),
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
