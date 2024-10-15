import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/Extensions/custom_text_field.dart';
import '../../RiderWidget.dart';

class SearchHomeWidget extends StatelessWidget {
  const SearchHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   "assets/icons/location.png",
                    //   height: 25,
                    //   width: 25,
                    // ),
                    IconButton(
                        onPressed: () {
                          // controller.destinationController.clear();
                        },
                        autofocus: false,
                        icon: SvgPicture.asset('assets/images/closeIcon.svg')),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          // await controller
                          //     .placeSelectAPI(context)
                          //     .then((value) {
                          //   if (value != null) {
                          //     controller.destinationController.text =
                          //         value.result.formattedAddress.toString();
                          //     setDestinationMarker(LatLng(
                          //         value.result.geometry!.location.lat,
                          //         value.result.geometry!.location.lng));
                          //   }
                          // });
                        },
                        child: buildTextField(
                          title: "تحديد موقع الوجهة",
                          textController: TextEditingController(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      autofocus: false,
                      icon: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                // TopRiderWidget(
                //   title: '',
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
