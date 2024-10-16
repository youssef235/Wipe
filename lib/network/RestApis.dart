import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import '../main.dart';
import '../model/AppSettingModel.dart';
// import 'package:taxi_booking/model/CarDetailsModel.dart';
import '../model/CarDetailsModel.dart';
import '../model/ChangePasswordResponseModel.dart';
import '../model/ComplaintCommentModel.dart';
import '../model/ContactNumberListModel.dart';
import '../model/CouponListModel.dart';
import '../model/CurrentRequestModel.dart';
import '../model/EstimatePriceModel.dart';
import '../model/GoogleMapSearchModel.dart';
import '../model/GooglePlaceIdModel.dart';
import '../model/LDBaseResponse.dart';
import '../model/LoginResponse.dart';
import '../model/NearByDriverModel.dart';
import '../model/NotificationListModel.dart';
import '../model/PaymentListModel.dart';
import '../model/RideDetailModel.dart';
import '../model/RiderListModel.dart';
import '../model/UserDetailModel.dart';
import '../model/WalletInfoModel.dart';
import '../model/WalletListModel.dart';
import '../model/WithDrawListModel.dart';
// import '../model/packages_model.dart';
import '../model/vehicle_model/datum.dart';
import '../model/vehicle_model/vehicle_model.dart';
import '../model/wash_type/wash_type.dart';
import '../screens/SignInScreen.dart';
import '../screens/sign_in_screen.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/StringExtensions.dart';
import '../utils/Extensions/app_common.dart';
import 'NetworkUtils.dart';

Future<LoginResponse> signUpApi(Map request) async {
  Response response = await buildHttpResponse('register',
      request: request, method: HttpMethod.POST);

  if (!(response.statusCode >= 200 && response.statusCode <= 206)) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') &&
          json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    var loginResponse = LoginResponse.fromJson(json);

    if (loginResponse.data!.loginType == 'mobile') {
      await sharedPref.setString(
          TOKEN, loginResponse.data!.apiToken.validate());
      await sharedPref.setString(
          USER_TYPE, loginResponse.data!.userType.validate());
      await sharedPref.setString(
          FIRST_NAME, loginResponse.data!.firstName.validate());
      await sharedPref.setString(
          LAST_NAME, loginResponse.data!.lastName.validate());
      await sharedPref.setString(
          CONTACT_NUMBER, loginResponse.data!.contactNumber.validate());
      await sharedPref.setString(
          USER_EMAIL, loginResponse.data!.email.validate());
      await sharedPref.setString(
          USER_NAME, loginResponse.data!.username.validate());
      await sharedPref.setString(
          ADDRESS, loginResponse.data!.address.validate());
      await sharedPref.setInt(USER_ID, loginResponse.data!.id!);
      await sharedPref.setString(
          USER_PROFILE_PHOTO, loginResponse.data!.profileImage.validate());
      await sharedPref.setString(GENDER, loginResponse.data!.gender.validate());
      await sharedPref.setString(
          LOGIN_TYPE, loginResponse.data!.loginType.validate());
      await appStore.setLoggedIn(true);
      await appStore.setUserEmail(loginResponse.data!.email.validate());
      await sharedPref.setString(UID, loginResponse.data!.uid.validate());
      await appStore
          .setUserProfile(loginResponse.data!.profileImage.validate());
    }

    return loginResponse;
  }).catchError((e) {
    toast(e.toString());
  });
}

Future<LoginResponse> logInApi(Map request,
    {bool isSocialLogin = false}) async {
  try {
    Response response = await buildHttpResponse(
      'login',
      request: request,
      method: HttpMethod.POST,
    );

    // التحقق من حالة الاستجابة
    if (response.statusCode >= 200 && response.statusCode <= 206) {
      // التعامل مع استجابة الخادم
      return await handleResponse(response).then((json) async {
        var loginResponse = LoginResponse.fromJson(json);
        print('${loginResponse.data!.apiToken}');
        if (loginResponse.data != null) {
          if (loginResponse.data!.apiToken != null) {
            await sharedPref.setString(TOKEN, loginResponse.data!.apiToken!);
          }
          await sharedPref.setString(
              USER_TYPE, loginResponse.data!.userType.validate());
          await sharedPref.setString(
              FIRST_NAME, loginResponse.data!.firstName.validate());
          await sharedPref.setString(
              LAST_NAME, loginResponse.data!.lastName.validate());
          await sharedPref.setString(
              CONTACT_NUMBER, loginResponse.data!.contactNumber.validate());
          await sharedPref.setString(
              USER_EMAIL, loginResponse.data!.email.validate());
          await sharedPref.setString(
              USER_NAME, loginResponse.data!.username.validate());
          await sharedPref.setString(
              ADDRESS, loginResponse.data!.address.validate());
          await sharedPref.setInt(USER_ID, loginResponse.data!.id ?? 0);
          await sharedPref.setString(
              USER_PROFILE_PHOTO, loginResponse.data!.profileImage.validate());
          await sharedPref.setString(
              GENDER, loginResponse.data!.gender.validate());
          await sharedPref.setString(
              LOGIN_TYPE, loginResponse.data!.loginType.validate());
          await appStore.setLoggedIn(true);
          await appStore.setUserEmail(loginResponse.data!.email.validate());
          if (loginResponse.data!.uid != null) {
            await sharedPref.setString(UID, loginResponse.data!.uid.validate());
          }
          await appStore
              .setUserProfile(loginResponse.data!.profileImage.validate());
        }

        return loginResponse;
      });
    } else {
      // التعامل مع الاستجابة غير الناجحة
      if (response.body.isJson()) {
        var json = jsonDecode(response.body);

        if (json.containsKey('code') &&
            json['code'].toString().contains('invalid_username')) {
          throw 'invalid_username';
        }
      }
      throw 'Request failed with status: ${response.statusCode}';
    }
  } catch (e) {
    // تسجيل الخطأ والتعامل معه
    log('Error: ${e.toString()}');
    throw 'Login failed: ${e.toString()}';
  }
}

Future<VerifyOtpResponse> verifyOtpApi(Map<String, String> request) async {
  try {
    // تنفيذ الطلب
    Response response = await buildHttpResponse(
      'verify-otp',
      request: request,
      method: HttpMethod.POST,
    );

    // التحقق من حالة الاستجابة
    if (response.statusCode >= 200 && response.statusCode <= 206) {
      var json = await handleResponse(response);

      // التحقق من وجود التوكن في الاستجابة
      var token = json['token'];
      if (token != null && token.isNotEmpty) {
        print("Token received: $token");
        await sharedPref.setString(TOKEN, token);
        appStore.isLoggedIn = true; // تأكد من ضبط الحالة على تسجيل الدخول
      } else {
        throw 'Token is missing in the response';
      }

      // تخزين بيانات المستخدم في SharedPreferences
      var user = json['user'];
      if (user != null) {
        await sharedPref.setInt(USER_ID, user['id'] ?? 0);
        await sharedPref.setString(USER_TYPE, user['user_type']?.toString() ?? '');
        await sharedPref.setString(FIRST_NAME, user['first_name']?.toString() ?? '');
        await sharedPref.setString(LAST_NAME, user['last_name']?.toString() ?? '');
        await sharedPref.setString(CONTACT_NUMBER, user['contact_number']?.toString() ?? '');
        await sharedPref.setString(USER_EMAIL, user['email']?.toString() ?? '');
        await sharedPref.setString(USER_NAME, user['username']?.toString() ?? '');
        await sharedPref.setString(ADDRESS, user['address']?.toString() ?? '');
        await sharedPref.setString(USER_PROFILE_PHOTO, user['profile_image']?.toString() ?? '');
        await sharedPref.setString(GENDER, user['gender']?.toString() ?? '');
        await appStore.setUserProfile(user['profile_image']?.toString() ?? '');
      }

      return VerifyOtpResponse.fromJson(json);
    } else {
      throw 'Request failed with status: ${response.statusCode}';
    }
  } catch (e) {
    log('Error: ${e.toString()}');
    throw 'OTP verification failed: ${e.toString()}';
  }
}

Future<MultipartRequest> getMultiPartRequest(String endPoint,
    {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  log('Request URL: $url');

  // إنشاء طلب متعدد الأجزاء
  MultipartRequest multiPartRequest = MultipartRequest('POST', Uri.parse(url));

  // إضافة الهيدر مع التوكن
  String? token = sharedPref.getString(TOKEN);
  if (token != null && token.isNotEmpty) {
    multiPartRequest.headers['Authorization'] = 'Bearer $token';
    log('Authorization header added with token');
  } else {
    log('Warning: Token is missing. Authorization header will not be added.');
  }

  return multiPartRequest;
}


Future sendMultiPartRequest(MultipartRequest multiPartRequest,
    {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  multiPartRequest.headers.addAll(buildHeaderTokens());

  await multiPartRequest.send().then((res) {
    log(res.statusCode);
    res.stream.transform(utf8.decoder).listen((value) {
      log(value);
      onSuccess?.call(jsonDecode(value));
    });
  }).catchError((error) {
    onError?.call(error.toString());
  });
}

/// Profile Update
Future updateProfile({
  String? uid,
  String? firstName,
  String? lastName,
  String? userEmail,
  String? address,
  String? contactNumber,
  String? username,
  String? password,
  File? file,
}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
  multiPartRequest.fields['id'] = sharedPref.getInt(USER_ID)?.toString() ?? '';
  multiPartRequest.fields['username'] = username?.validate() ?? '';
  multiPartRequest.fields['email'] = userEmail ?? appStore.userEmail ?? '';
  multiPartRequest.fields['first_name'] = firstName?.validate() ?? '';
  multiPartRequest.fields['last_name'] = lastName?.validate() ?? '';
  multiPartRequest.fields['contact_number'] = contactNumber?.validate() ?? '';
  multiPartRequest.fields['address'] = address?.validate() ?? '';
  multiPartRequest.fields['uid'] = uid?.validate() ?? '';
  multiPartRequest.fields['player_id'] = sharedPref.getString(PLAYER_ID) ?? '';
  multiPartRequest.fields['password'] = password ?? '12345678';
  multiPartRequest.fields['password_confirmation'] = password ?? '12345678';

  if (file != null) {
    multiPartRequest.files.add(await MultipartFile.fromPath('file', file.path));
  }

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      LoginResponse res = LoginResponse.fromJson(data);
      await sharedPref.setString(FIRST_NAME, res.data?.firstName ?? '');
      await sharedPref.setString(LAST_NAME, res.data?.lastName ?? '');
      await sharedPref.setString(USER_PROFILE_PHOTO, res.data?.profileImage ?? '');
      await sharedPref.setString(USER_NAME, res.data?.username ?? '');
      await sharedPref.setString(USER_ADDRESS, res.data?.address ?? '');
      await sharedPref.setString(CONTACT_NUMBER, res.data?.contactNumber ?? '');
      await sharedPref.setString(GENDER, res.data?.gender ?? '');
      await appStore.setUserEmail(res.data?.email ?? '');
      await appStore.setUserProfile(res.data?.profileImage ?? '');
    }
  }, onError: (error) {
    toast(error.toString());
  });
}


Future<void> logout({bool isDelete = false}) async {
  if (!isDelete) {
    await logoutApi().then((value) async {
      logOutSuccess();
    }).catchError((e) {
      throw e.toString();
    });
  } else {
    logOutSuccess();
  }
}

Future<ChangePasswordResponseModel> changePassword(Map req) async {
  return ChangePasswordResponseModel.fromJson(await handleResponse(
      await buildHttpResponse('change-password',
          request: req, method: HttpMethod.POST)));
}

Future<ChangePasswordResponseModel> forgotPassword(Map req) async {
  return ChangePasswordResponseModel.fromJson(await handleResponse(
      await buildHttpResponse('forget-password',
          request: req, method: HttpMethod.POST)));
}

// Future<ServiceModel> getServices() async {
//   return ServiceModel.fromJson(await handleResponse(
//       await buildHttpResponse('service-list', method: HttpMethod.GET)));
// }

Future<WashType> getWashServices() async {
  return WashType.fromMap(await handleResponse(await buildHttpResponse(
      'service-list?type_service=0',
      method: HttpMethod.GET)));
}

Future<WashType> getAdditionalServices() async {
  return WashType.fromMap(await handleResponse(await buildHttpResponse(
      'service-list?type_service=1',
      method: HttpMethod.GET)));
}

Future<LoginResponse> getUserDetail({int? userId}) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse(
      'user-detail?id=$userId',
      method: HttpMethod.GET)));
}

Future<LDBaseResponse> changeStatusApi(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'update-user-status',
      method: HttpMethod.POST,
      request: request)));
}

Future<LDBaseResponse> saveBooking(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'update-user-status',
      method: HttpMethod.POST,
      request: request)));
}

Future<WalletListModel> getWalletList({required int page}) async {
  return WalletListModel.fromJson(await handleResponse(await buildHttpResponse(
      'wallet-list?page=$page',
      method: HttpMethod.GET)));
}

Future<PaymentListModel> getPaymentList() async {
  return PaymentListModel.fromJson(await handleResponse(await buildHttpResponse(
      'payment-gateway-list?status=1',
      method: HttpMethod.GET)));
}

Future<LDBaseResponse> saveWallet(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-wallet',
      method: HttpMethod.POST,
      request: request)));
}

Future<LDBaseResponse> saveSOS(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-sos',
      method: HttpMethod.POST,
      request: request)));
}

Future<ContactNumberListModel> getSosList({int? regionId}) async {
  return ContactNumberListModel.fromJson(await handleResponse(
      await buildHttpResponse(
          regionId != null ? 'sos-list?region_id=$regionId' : 'sos-list',
          method: HttpMethod.GET)));
}

Future<ContactNumberListModel> deleteSosList({int? id}) async {
  return ContactNumberListModel.fromJson(await handleResponse(
      await buildHttpResponse('sos-delete/$id', method: HttpMethod.POST)));
}

Future<EstimatePriceModel> estimatePriceList(Map request) async {
  return EstimatePriceModel.fromJson(await handleResponse(
      await buildHttpResponse('estimate-price-time',
          method: HttpMethod.POST, request: request)));
}

Future<CouponListModel> getCouponList() async {
  return CouponListModel.fromJson(await handleResponse(
      await buildHttpResponse('coupon-list', method: HttpMethod.GET)));
}

Future<LDBaseResponse> savePayment(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-payment',
      method: HttpMethod.POST,
      request: request)));
}

Future<LDBaseResponse> saveRideRequest(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-riderequest',
      method: HttpMethod.POST,
      request: request)));
}

Future<AppSettingModel> getAppSetting() async {
  return AppSettingModel.fromJson(await handleResponse(
      await buildHttpResponse('admin-dashboard', method: HttpMethod.GET)));
}

Future<CurrentRequestModel> getCurrentRideRequest() async {
  return CurrentRequestModel.fromJson(await handleResponse(
      await buildHttpResponse('current-riderequest', method: HttpMethod.GET)));
}

Future<LDBaseResponse> rideRequestUpdate(
    {required Map request, int? rideId}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'riderequest-update/$rideId',
      method: HttpMethod.PATCH,
      request: request)));
}

Future<LDBaseResponse> ratingReview({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-ride-rating',
      method: HttpMethod.POST,
      request: request)));
}

Future<LDBaseResponse> adminNotify({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'admin-sos-notify',
      method: HttpMethod.POST,
      request: request)));
}

Future<RiderListModel> getRiderRequestList(
    {int? page, String? status, LatLng? sourceLatLog, int? riderId}) async {
  if (sourceLatLog != null) {
    return RiderListModel.fromJson(await handleResponse(await buildHttpResponse(
        'riderequest-list?page=$page&rider_id=$riderId',
        method: HttpMethod.GET)));
  } else {
    return RiderListModel.fromJson(await handleResponse(await buildHttpResponse(
        status != null
            ? 'riderequest-list?page=$page&status=$status&rider_id=$riderId'
            : 'riderequest-list?page=$page&rider_id=$riderId',
        method: HttpMethod.GET)));
  }
}

Future<LDBaseResponse> saveComplain({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-complaint',
      method: HttpMethod.POST,
      request: request)));
}

Future<RideDetailModel> rideDetail({required int? orderId}) async {
  return RideDetailModel.fromJson(await handleResponse(await buildHttpResponse(
      'riderequest-detail?id=$orderId',
      method: HttpMethod.GET)));
}

/// Get Notification List
Future<NotificationListModel> getNotification({required int page}) async {
  return NotificationListModel.fromJson(await handleResponse(
      await buildHttpResponse('notification-list?page=$page&limit=$PER_PAGE',
          method: HttpMethod.POST)));
}

Future<GoogleMapSearchModel> searchAddressRequest({String? search}) async {
  return GoogleMapSearchModel.fromJson(await handleResponse(await buildHttpResponse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$GOOGLE_MAP_API_KEY&components=country:${sharedPref.getString(COUNTRY).validate(value: defaultCountry)}',
      method: HttpMethod.GET)));
}

Future<GoogleMapSearchModelLatAndLong> getAddressFromLatLng(
    double lat, double lng) async {
  final String url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_MAP_API_KEY';

  var response = await buildHttpResponse(url, method: HttpMethod.GET);

  var jsonResponse = await handleResponse(response);

  return GoogleMapSearchModelLatAndLong.fromJson(jsonResponse);
}

Future<GooglePlaceIdModel> searchAddressRequestPlaceId(
    {String? placeId}) async {
  return GooglePlaceIdModel.fromJson(await handleResponse(await buildHttpResponse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAP_API_KEY',
      method: HttpMethod.GET)));
}

Future<LoginResponse> updateStatus(Map request) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse(
      'update-user-status',
      method: HttpMethod.POST,
      request: request)));
}

Future<LDBaseResponse> deleteUser() async {
  return LDBaseResponse.fromJson(await handleResponse(
      await buildHttpResponse('delete-user-account', method: HttpMethod.POST)));
}

/// Packages
// Future<PackagesModel> getPackages() async {
//   return PackagesModel.fromJson(await handleResponse(
//       await buildHttpResponse('package-list', method: HttpMethod.GET)));
// }

/// vehicles
Future<VehicleModel> getVehicles() async {
  final response = await handleResponse(
    await buildHttpResponse('vehicles', method: HttpMethod.GET),
  );
  print("Response from getVehicles: $response"); // إضافة هذا السطر
  return VehicleModel.fromMap(response);
}

Future<VehicleObject> addVehicle({
  required String brand,
  required String model,
  required String color,
  required String carNum,
}) async {
  final response = await buildAddVehicleHttpResponse(
    'vehicles', // نقطة النهاية
    request: {
      'manufacturer_name': brand,
      'vehicle_type': model,
      'vehicle_color': color,
      'vehicle_cardNum': carNum,
    },
  );

  return VehicleObject.fromMap(await handleResponse(response));
}



Future<LDBaseResponse> renewSubscripe({required int subscripeId}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'renew-subscripe-on-package/$subscripeId',
      method: HttpMethod.POST)));
}

Future<int> subscripe({required int packageId}) async {
  dynamic data = await handleResponse(await buildHttpResponse(
      'subscripe-on-package/$packageId',
      method: HttpMethod.POST));
  return data['data']['id'];
}

Future<CarDetailsModel> addCar(
    {required int packageId,
    required String companyName,
    required String type,
    required String color,
    required String carNum}) async {
  final data = await handleResponse(await buildHttpResponse(
    'add-vehicle-attributes/$packageId',
    method: HttpMethod.POST,
    request: {
      'manufacturer_name': companyName,
      'vehicle_type': type,
      'vehicle_color': color,
      'vehicle_cardNum': carNum,
    },
  ));
  return CarDetailsModel.fromJson(data['data']);
}

/// Profile Update
Future updateProfileUid() async {
  MultipartRequest multiPartRequest =
      await getMultiPartRequest('update-profile');
  multiPartRequest.fields['id'] = sharedPref.getInt(USER_ID).toString();
  multiPartRequest.fields['username'] =
      sharedPref.getString(USER_NAME).validate();
  multiPartRequest.fields['email'] =
      sharedPref.getString(USER_EMAIL).validate();
  multiPartRequest.fields['uid'] = sharedPref.getString(UID).toString();

  log('multipart request:${multiPartRequest.fields}');
  log(sharedPref.getString(UID).toString());

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      //
    }
  }, onError: (error) {
    toast(error.toString());
  });
}

Future<LDBaseResponse> complaintComment({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-complaintcomment',
      method: HttpMethod.POST,
      request: request)));
}

Future<ComplaintCommentModel> complaintList(
    {required int complaintId, required int currentPage}) async {
  return ComplaintCommentModel.fromJson(await handleResponse(
      await buildHttpResponse(
          'complaintcomment-list?complaint_id=$complaintId&page=$currentPage',
          method: HttpMethod.GET)));
}

Future<LDBaseResponse> logoutApi() async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'logout?clear=player_id',
      method: HttpMethod.GET)));
}

Future<UserDetailModel> getDriverDetail({int? userId}) async {
  return UserDetailModel.fromJson(await handleResponse(await buildHttpResponse(
      'user-detail?id=$userId',
      method: HttpMethod.GET)));
}

logOutSuccess() async {
  sharedPref.remove(FIRST_NAME);
  sharedPref.remove(LAST_NAME);
  sharedPref.remove(USER_PROFILE_PHOTO);
  sharedPref.remove(USER_NAME);
  sharedPref.remove(USER_ADDRESS);
  sharedPref.remove(CONTACT_NUMBER);
  sharedPref.remove(GENDER);
  sharedPref.remove(UID);
  sharedPref.remove(TOKEN);
  sharedPref.remove(USER_TYPE);
  sharedPref.remove(ADDRESS);
  sharedPref.remove(USER_ID);
  sharedPref.remove(COUNTRY);
  appStore.setLoggedIn(false);
  if (!(sharedPref.getBool(REMEMBER_ME) ?? false) ||
      sharedPref.getString(LOGIN_TYPE) == LoginTypeGoogle ||
      sharedPref.getString(LOGIN_TYPE) == 'mobile') {
    sharedPref.remove(USER_EMAIL);
    sharedPref.remove(USER_PASSWORD);
    sharedPref.remove(REMEMBER_ME);
  }
  sharedPref.remove(LOGIN_TYPE);
  launchScreen(getContext, SignInScreenNew(), isNewTask: true);
}

Future<NearByDriverModel> getNearByDriverList({LatLng? latLng}) async {
  return NearByDriverModel.fromJson(await handleResponse(await buildHttpResponse(
      'near-by-driver?latitude=${latLng!.latitude}&longitude=${latLng.longitude}',
      method: HttpMethod.GET)));
}

Future<AppSettingModel> getAppSettingApi() async {
  return AppSettingModel.fromJson(await handleResponse(
      await buildHttpResponse('appsetting', method: HttpMethod.GET)));
}

Future<WalletInfoModel> getWalletData() async {
  return WalletInfoModel.fromJson(await handleResponse(
      await buildHttpResponse('wallet-detail', method: HttpMethod.GET)));
}

Future<WithDrawListModel> getWithDrawList({int? page}) async {
  return WithDrawListModel.fromJson(await handleResponse(
      await buildHttpResponse('withdrawrequest-list?page=$page',
          method: HttpMethod.GET)));
}

Future<LDBaseResponse> saveWithDrawRequest(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'save-withdrawrequest',
      method: HttpMethod.POST,
      request: request)));
}

/// Update Bank Info
Future updateBankDetail(
    {String? bankName,
    String? bankCode,
    String? accountName,
    String? accountNumber}) async {
  MultipartRequest multiPartRequest =
      await getMultiPartRequest('update-profile');
  multiPartRequest.fields['email'] =
      sharedPref.getString(USER_EMAIL).validate();
  multiPartRequest.fields['contact_number'] =
      sharedPref.getString(CONTACT_NUMBER).validate();
  multiPartRequest.fields['username'] =
      sharedPref.getString(USER_NAME).validate();
  multiPartRequest.fields['user_bank_account[bank_name]'] = bankName.validate();
  multiPartRequest.fields['user_bank_account[bank_code]'] = bankCode.validate();
  multiPartRequest.fields['user_bank_account[account_holder_name]'] =
      accountName.validate();
  multiPartRequest.fields['user_bank_account[account_number]'] =
      accountNumber.validate();

  log('Request:${multiPartRequest.fields}');

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    log('data:$data');
    if (data != null) {
      //
    }
  }, onError: (error) {
    toast(error.toString());
  });
}
