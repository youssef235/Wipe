import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';

import 'theme_helper.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        toolbarHeight: height ?? 68.v,
        automaticallyImplyLeading: false,
        backgroundColor: appTheme.primary,
        leadingWidth: leadingWidth ?? 0,
        leading: leading,
        title: title,
        titleSpacing: 0,
        centerTitle: centerTitle ?? false,
        actions: actions,
        scrolledUnderElevation: 0);
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 68.v,
      );
}