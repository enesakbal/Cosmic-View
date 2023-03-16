import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.validator,
      this.onChanged,
      this.hintText,
      this.enabledColor,
      this.focusedColor,
      this.fillColor,
      this.prefixIconColor,
      this.prefixIcon,
      this.suffixIconColor,
      this.suffixIcon,
      this.readOnly = false});

  final String? hintText;

  final TextEditingController controller;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final Color? focusedColor;
  final Color? enabledColor;
  final Color? fillColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 10.h,
      child: Center(
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          scrollPadding: EdgeInsets.zero,
          cursorColor: Colors.white,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.grey,
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(12),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorStyle: TextStyle(
              color: Colors.white,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.5),
            ),
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor,
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor,
          ),
        ),
      ),
    );
  }
}
