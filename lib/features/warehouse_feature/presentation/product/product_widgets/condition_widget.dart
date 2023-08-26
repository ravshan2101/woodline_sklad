import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionWidget extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;

  const ConditionWidget({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      height: 30.h,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20.sp),
          ScreenUtil().setHorizontalSpacing(5),
          Text(text),
        ],
      ),
    );
  }
}
