import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:taxi_booking/main.dart';
import 'package:taxi_booking/model/wash_type/wash_type.dart';
import 'package:taxi_booking/screens/packages/select_car_screen.dart';
import 'package:taxi_booking/utils/Extensions/context_extension.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../model/vehicle_model/vehicle_model.dart';
import '../../model/wash_type/datum.dart';
import '../../network/RestApis.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/custom_button_style.dart';
import '../../utils/Extensions/custom_elevated_button.dart';
import '../CheckoutScreen/CheckoutScreen.dart';


class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  VehicleModel? vehicleModel;
  WashType? washType;
  final double buttonWidth = 550.h;
  final double buttonHeight = 130.v;

  // قائمة بأنواع الغسل
  final List<String> washTypes = [
    'إختر',
    'غسل سريع',
    'غسل شامل',
    'غسل داخلي',
    'غسل خارجي'
  ];
  String selectedWashType = '';
  int selectedWashPrice = 0; // تغيير إلى double

  final Map<String, Map<String, dynamic>> washTypeDetails = {
    'غسل سريع': {'id': 1, 'price': 60},
    'غسل شامل': {'id': 2, 'price': 170},
    'غسل داخلي': {'id': 3, 'price': 110},
    'غسل خارجي': {'id': 4, 'price': 100},
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    selectedWashType = washTypes[0];
    selectedWashPrice = 0; // تعيين القيمة الأولية
    init();
  }

  DateTime? _selectedDate = DateTime.now();

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  init() async {
    print("your token is ${await sharedPref.getString("TOKEN")}");

    try {
      // استرجاع العربات
      vehicleModel = await getVehicles();

      // إعادة بناء الواجهة مع البيانات الجديدة
      setState(() {});
    } catch (e) {
      print("Error: $e"); // طباعة الخطأ في حالة حدوثه
      toast(e.toString()); // يمكنك استعراض الخطأ للمستخدم
    }

    // استرجاع خدمات الغسل
    try {
      washType = await getWashServices();
      setState(() {});
    } catch (e) {
      print("Error fetching wash services: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.primary,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: context.statusBarHeight,
                ),
                Positioned(
                  top: context.statusBarHeight ,
                  right: 8,
                  left: 8,
                  child: CustomRowWidget(),
                ),
                SizedBox(
                  height: 120.v,
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
                    height: 200.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        if (i == 0) {
                          return Center(
                            child: SelectCarWidget(
                              onTap: () {
                                if (appStore.selectedMainServiceId == null) {
                                  toast('برجاء إختيار نوع الغسل');
                                } else {
                                  launchScreen(context, SelectCarScreen(),
                                      isNewTask: false);
                                }
                              },
                              carId: 0,
                              text: 'إضافة سيارة',
                              image: 'images/add.png',
                            ),
                          );
                        }
                        return Center(
                          child: SelectCarWidget(
                            text: vehicleModel!.data![i - 1].manufacturerName,
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
                  height: 120.v,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'نوع الغسل',
                    style: TextStyle(
                        color: Color(0xff201B51),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.v,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: appTheme.secondry,
                      borderRadius: BorderRadius.circular(63),
                    ),
                    child: DropdownButton2<String>(
                      value: selectedWashType,
                      hint: Center(
                        child: const Text(
                          'Select an option',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWashType = newValue!;
                          appStore.selectedMainServiceId = washTypeDetails[selectedWashType]?['id']; // تحديث ID الخدمة
                          selectedWashPrice = washTypeDetails[selectedWashType]?['price']; // تحديث السعر
                        });
                      },
                      items: washTypes.map<DropdownMenuItem<String>>((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Center(
                            child: Text(
                              type,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: buttonWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: appTheme.secondry,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: appTheme.secondry,
                        ),
                        offset: const Offset(0, 0), // ضبط الإزاحة لتكون مركزية
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      underline: SizedBox.shrink(),
                    ),
                  ),

                ),

                SizedBox(
                  height: 60.v,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'التاريخ',
                    style: TextStyle(
                        color: Color(0xff201B51),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.v,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: appTheme.secondry,
                      borderRadius: BorderRadius.circular(63),
                    ),
                    child: Center(
                      child: Text(
                        _formatDate(_selectedDate!),
                        style: TextStyle(color: appTheme.primary, fontSize: 20),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 90.v,
            child: Align(
              alignment: Alignment.center,
              child: CustomElevatedButton(
                text: 'إستمرار',
                height: buttonHeight,
                width: buttonWidth,
                buttonTextStyle: TextStyle(
                  color: appTheme.secondry,
                  fontSize: 16,
                ),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onPressed: () {
                  if (appStore.selectedMainServiceId == null) {
                    toast('برجاء إختيار نوع الغسل');
                  } else if (appStore.carId == null) {
                    toast('برجاء إختيار السيارة');
                  } else {
                    // تمرير البيانات إلى الشاشة التالية
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          selectedCarId: appStore.carId!, // إرسال ID السيارة
                          selectedWashType: selectedWashType,
                          washPrice: selectedWashPrice, // إرسال السعر المحدد
                          selectedDate: _selectedDate!,
                          serviceId: appStore.selectedMainServiceId!,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
