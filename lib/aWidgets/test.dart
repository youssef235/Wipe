// import 'package:firebase_auth/firebase_auth.dart';
//
// class PhoneAuthService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> verifyPhoneNumber(
//       String phoneNumber, Function(String, String) codeSent) async {
//     print('Attempting to send OTP to $phoneNumber');
//
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: "+20${phoneNumber}",
//         timeout: Duration(seconds: 60),
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           print('Verification completed automatically');
//           await _auth.signInWithCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print('Verification failed: ${e.message}');
//           throw e.message!;
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           print('OTP sent successfully. Verification ID: $verificationId');
//
//           codeSent(verificationId, phoneNumber);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           print('Auto retrieval timeout for verification ID: $verificationId');
//         },
//       );
//     } catch (error) {
//       print('Error during OTP sending: $error');
//       throw error; // رفع الاستثناء عند حدوث خطأ
//     }
//   }
//
//   // دالة لإرسال verificationId، رقم الهاتف، ورمز OTP إلى الـ API
//   Future<void> verifyWithApi(
//       String phoneNumber, String verificationId, String smsCode) async {
//     try {
//       var response =
//           await Dio().post('https://your-api-endpoint/verify-otp', data: {
//         'phone_number': phoneNumber,
//         'verification_id': verificationId,
//         'otp_code': smsCode,
//       });
//
//       if (response.statusCode == 200) {
//         print('Successfully verified via API');
//       } else {
//         print('Error verifying via API: ${response.statusCode}');
//         throw Exception('Verification failed');
//       }
//     } catch (e) {
//       print('API request error: $e');
//       throw e;
//     }
//   }
// }
