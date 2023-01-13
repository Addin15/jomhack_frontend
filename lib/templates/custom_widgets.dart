// Custom TextFormField
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../themes/colors.dart';

TextFormField customTextFormField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String hintText,
  required String? Function(String?)? validator,
  bool isObscured = false,
  EdgeInsetsGeometry? contentPadding,
  void Function(String)? onChanged,
}) =>
    TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscured,
      validator: validator,
      style: TextStyle(
        fontSize: 12.sp,
        color: AppColor.secondary,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
        isDense: true,
        isCollapsed: true,
        fillColor: AppColor.background,
        filled: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 1.2.h,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );

// Custom TextButton
TextButton customTextButton({
  required String label,
  required void Function()? onPressed,
  Color backgroundColor = AppColor.tertiary,
}) =>
    TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColor.background,
          fontSize: 12.sp,
        ),
      ),
    );
