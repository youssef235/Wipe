// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:taxi_booking/main.dart';
// import 'package:taxi_booking/utils/Extensions/context_extension.dart';
// import 'package:taxi_booking/utils/Extensions/size_utils.dart';
// import 'package:taxi_booking/utils/Extensions/theme_helper.dart';
//
// import '../../components/drawer_component.dart';
// import '../../model/wash_type/datum.dart';
// import '../../model/wash_type/wash_type.dart';
// import '../../network/RestApis.dart';
// import '../../utils/Common.dart';
// import '../../utils/Extensions/app_common.dart';
// import '../../utils/Extensions/custom_button_style.dart';
// import '../../utils/Extensions/custom_elevated_button.dart';
// import '../CheckoutScreen/CheckoutScreen.dart';
// import '../main_screen/main_screen.dart';
//
// class AdditionalServicesScreen extends StatefulWidget {
//   const AdditionalServicesScreen({super.key});
//
//   @override
//   State<AdditionalServicesScreen> createState() =>
//       _AdditionalServicesScreenState();
// }
//
// class _AdditionalServicesScreenState extends State<AdditionalServicesScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   WashType? washType;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   init() async {
//     await getAdditionalServices().then(
//           (value) {
//         washType = value;
//         setState(() {});
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: appTheme.primary,
//       drawer: DrawerComponent(),
//       body: Stack(
//         fit: StackFit.expand,
//         alignment: Alignment.center,
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: context.statusBarHeight + 4,
//                   ),
//                   topWidget(_scaffoldKey),
//                   SizedBox(
//                     height: 120.v,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'خدمات إضافية ',
//                       style: TextStyle(
//                         color: Color(0xff201B51),
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: SizedBox(
//                       height: 600.h,
//                       child: ListView.separated(
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (c, i) {
//                           return AdditionialServiceWidget(
//                               washTypeService: washType!.data![i]);
//                         },
//                         separatorBuilder: (context, i) {
//                           return SizedBox(
//                             height: 20.h,
//                           );
//                         },
//                         itemCount: washType?.data?.length ?? 0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 50.h, // المسافة من الأسفل
//             left: 20.h, // المسافة من اليسار
//             right: 20.h, // المسافة من اليمين
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 CustomElevatedButton(
//                   text: 'تـخطـي',
//                   height: 122.v,
//                   width: 250.h, // عرض الزر
//                   buttonTextStyle: TextStyle(
//                     color: appTheme.secondry,
//                     fontSize: 16,
//                   ),
//                   buttonStyle: CustomButtonStyles.fillPrimary,
//                   onPressed: () {
//                 //    launchScreen(context, CheckoutScreen(), isNewTask: false);
//                   },
//                 ),
//                 CustomElevatedButton(
//                   text: 'تأكيد',
//                   height: 122.v,
//                   width: 250.h, // عرض الزر
//                   buttonTextStyle: TextStyle(
//                     color: appTheme.secondry,
//                     fontSize: 16,
//                   ),
//                   buttonStyle: CustomButtonStyles.fillPrimary,
//                   onPressed: () {
//                     // إضافة الإجراءات اللازمة عند الضغط على زر "تأكيد"
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AdditionialServiceWidget extends StatelessWidget {
//   const AdditionialServiceWidget({
//     super.key,
//     this.isSelected,
//     required this.washTypeService,
//   });
//   final bool? isSelected;
//   final WashTypeService washTypeService;
//
//   @override
//   Widget build(BuildContext context) {
//     return Observer(builder: (context) {
//       return InkWell(
//         onTap: () {
//           appStore.setselectedAdditionalServiceId(washTypeService.id!);
//         },
//         child: Container(
//           width: 752.h,
//           height: 104.v,
//           decoration: BoxDecoration(
//             color: appStore.selectedAdditionalServiceId != washTypeService.id
//                 ? appTheme.primary
//                 : appTheme.secondry,
//             borderRadius: BorderRadius.circular(36),
//             border: Border.all(color: appTheme.black90001, width: 1.5),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Text(
//                   '${washTypeService.basePrice ?? ""}',
//                   textDirection: TextDirection.ltr,
//                   style: TextStyle(
//                     color: appStore.selectedAdditionalServiceId == washTypeService.id
//                         ? appTheme.primary
//                         : appTheme.secondry,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Text(
//                   '${washTypeService.name ?? ""}',
//                   style: TextStyle(
//                     color: appStore.selectedAdditionalServiceId == washTypeService.id
//                         ? appTheme.primary
//                         : appTheme.secondry,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
