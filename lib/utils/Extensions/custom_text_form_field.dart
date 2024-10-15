import 'package:flutter/material.dart';
import 'package:taxi_booking/utils/Extensions/size_utils.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = false,
      this.validator,
      this.height,
      this.cursorHeight,
      required this.textAlign,
      this.borderColor,
      this.borderWidth})
      : super(
          key: key,
        );
  final Color? borderColor;
  final double? borderWidth;

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;
  final double? height;
  final double? cursorHeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        height: height,
        child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: controller,
            // focusNode: FocusNode.,
            //  focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style:
                textStyle ?? TextStyle(fontSize: 16, color: appTheme.secondry),
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
            //  textDirection: TextDirection.rtl,
            cursorHeight: 0,
            showCursor: false,
            textAlign: textAlign),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? TextStyle(fontSize: 16),
        //  hintTextDirection: TextDirection.rtl,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(63.h),
              borderSide: BorderSide(
                color: borderColor ?? appTheme.blueGray400,
                width: borderWidth ?? 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(63.h),
              borderSide: BorderSide(
                color: borderColor ?? appTheme.blueGray400,
                width: borderWidth ?? 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(63.h),
              borderSide: BorderSide(
                color: borderColor ?? appTheme.blueGray400,
                width: borderWidth ?? 1,
              ),
            ),
      );
}
