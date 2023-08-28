import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? name;
  final Icon? icon;
  final int? vertical;
  final double? cursorHeight;
  final double fontsize;
  final TextEditingController? textEditingController;
  final ValueChanged? valueChanged;
  final Function(String)? onchaged;
  final String? Function(String?)? validator;
  final bool isBigTextfield;
  final TextInputType? keyboardType;
  final int? maxLength;

  const TextFieldWidget({
    super.key,
    this.name,
    this.icon,
    this.cursorHeight,
    this.fontsize = 15,
    this.textEditingController,
    this.onchaged,
    this.valueChanged,
    this.validator,
    required this.vertical,
    this.isBigTextfield = false,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLines: isBigTextfield ? 4 : 1,
      style: TextStyle(fontSize: 16.sp),
      validator: validator,
      onChanged: onchaged,
      controller: textEditingController,
      cursorHeight: cursorHeight,
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: vertical!.h),
          labelText: name,
          labelStyle: TextStyle(color: AppColors.grey, fontSize: fontsize),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blue),
              borderRadius: BorderRadius.circular(10.r)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10.r)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.r))),
    );
  }
}
