import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxi_booking/main.dart';
import 'package:taxi_booking/screens/additional_services/additional_services_screen.dart';
import 'package:taxi_booking/screens/packages/packages_screen.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/custom_text_form_field.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../model/packages_model.dart';
import '../../model/vehicle_model/vehicle_model.dart';
import '../../network/RestApis.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/custom_button_style.dart';
import '../../utils/Extensions/custom_elevated_button.dart';

class SelectCarScreen extends StatefulWidget {
  const SelectCarScreen({super.key});

  @override
  State<SelectCarScreen> createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends State<SelectCarScreen> {
  VehicleModel? vehicleModel;
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController plateController = TextEditingController();

  List<PackagesDatum> listOfPackages = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  dispose() {
    brandController.dispose();
    modelController.dispose();
    colorController.dispose();
    plateController.dispose();
    super.dispose();
  }

  init() async {
    await getVehicles().then(
      (value) {
        vehicleModel = value;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.primary,
      // drawer: DrawerComponent(),
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
                  Positioned(
                    top: context.statusBarHeight - 8,
                    right: 8,
                    left: 8,
                    child: CustomRowWidget(),
                  ),
                  //topWidget(_scaffoldKey),
                  SizedBox(
                    height: 100.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'إختر سيارتك',
                      style: TextStyle(
                          color: Color(0xff201B51),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 80.v,
                  ),
                  Center(
                    child: SizedBox(
                      height: 200.h, // تأكد من وجود مكتبة للحجم
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          if (i == 0) {
                            return InkWell(
                              onTap: () {
                              },
                              child: Center(
                                child: SelectCarWidget(
                                  carId: 0,
                                  text: 'أضف سيارة',
                                  image: 'images/add.png',
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: SelectCarWidget(
                              text: vehicleModel!.data![i - 1].vehicleCardNum,
                              type: vehicleModel!.data![i - 1].vehicleType,
                              carId: vehicleModel!.data![i - 1].id ?? 0,
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            width: 20.h,
                          );
                        },
                        itemCount: (vehicleModel?.data?.length ?? 0) + 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 767.v,
                      width: 644.h,
                      decoration: BoxDecoration(
                        color: appTheme.secondry,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 39.v,
                          ),
                          CustomTextFormField(
                            width: 567.12.h,
                            height: 100.v,
                            hintText: ' ماركة السيارة',
                            textAlign: TextAlign.center,
                            fillColor: appTheme.primary,
                            filled: true,
                            controller: brandController,
                          ),
                          SizedBox(
                            height: 33.v,
                          ),
                          CustomTextFormField(
                            width: 567.12.h,
                            height: 100.v,
                            hintText: 'الموديـل',
                            textAlign: TextAlign.center,
                            fillColor: appTheme.primary,
                            filled: true,
                            controller: modelController,
                          ),
                          SizedBox(
                            height: 33.v,
                          ),
                          CustomTextFormField(
                            width: 567.12.h,
                            height: 100.v,
                            hintText: 'اللون',
                            textAlign: TextAlign.center,
                            fillColor: appTheme.primary,
                            filled: true,
                            controller: colorController,
                          ),
                          SizedBox(
                            height: 33.v,
                          ),
                          CustomTextFormField(
                            width: 567.12.h,
                            height: 100.v,
                            hintText: ' لوحة السيارة (اختياري)',
                            textAlign: TextAlign.center,
                            fillColor: appTheme.primary,
                            filled: true,
                            controller: plateController,
                          ),
                          SizedBox(
                            height: 60.v,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomElevatedButton(
                              text: 'أضف السيارة',
                              width: 567.12.h,
                              height: 100.v,
                              buttonTextStyle: TextStyle(
                                color: appTheme.primary,
                                fontSize: 16,
                              ),
                              buttonStyle: CustomButtonStyles.fillSecondry,
                              onPressed: () {
                                // التأكد من أن جميع الحقول معبأة
                                if (brandController.text.isEmpty ||
                                    modelController.text.isEmpty ||
                                    colorController.text.isEmpty
                                   || plateController.text.isEmpty
                                ) {
                                  toast('يرجى ملء جميع الحقول');
                                  return;
                                }

                                // إذا كانت جميع الحقول معبأة، قم بإضافة السيارة
                                addVehicle(
                                  brand: brandController.text,
                                  model: modelController.text,
                                  color: colorController.text,
                                  carNum: plateController.text,
                                ).then((val) async {
                                  await getVehicles().then(
                                    (value) {
                                      vehicleModel = value;
                                      setState(() {});
                                    },
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100.v,
            child: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
              return isKeyboardVisible
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.center,
                      child: CustomElevatedButton(
                        text: 'إستمرار',
                        height: 122.v,
                        width: 637.h,
                        buttonTextStyle: TextStyle(
                          color: appTheme.secondry,
                          fontSize: 16,
                        ),
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        onPressed: () {
                          dev.log(appStore.carId.toString(), name: 'carId');
                          if (appStore.carId == null || appStore.carId == 0) {
                            toast('من فضلك إختر سيارة');
                          } else {
                           launchScreen(context, PackagesScreen(),
                               isNewTask: false);
                          }
                        },
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}

class SelectCarWidget extends StatefulWidget {
  const SelectCarWidget({
    super.key,
    this.image,
    this.text,
    this.type,
    required this.carId,
    this.onTap,
  });
  final String? image;
  final String? text;
  final String? type;
  final int carId;
  final VoidCallback? onTap;
  @override
  State<SelectCarWidget> createState() => _SelectCarWidgetState();
}

class _SelectCarWidgetState extends State<SelectCarWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Observer(builder: (context) {
        return InkWell(
          onTap: () {
            widget.onTap != null ? widget.onTap!() : null;
            appStore.setCarId(widget.carId);
          },
          child: Container(
            width: 150.88.h,
            height: 150.h,
            decoration: BoxDecoration(
              color: appStore.carId == widget.carId ? appTheme.secondry : null,
              border: Border.all(
                color: appTheme.secondry,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.image != null
                    ? Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 30.v,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                width: 40.29.h,
                                height: 40.v,
                                widget.image ?? 'images/jaguar.png',
                                color: appStore.carId != widget.carId
                                    ? appTheme.secondry
                                    : appTheme.primary,
                              ),
                            ),
                            SizedBox(
                              height: 10.v,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                Text(
                  widget.text ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appStore.carId != widget.carId
                          ? appTheme.secondry
                          : null,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.type ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appStore.carId != widget.carId
                          ? appTheme.secondry
                          : null,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
