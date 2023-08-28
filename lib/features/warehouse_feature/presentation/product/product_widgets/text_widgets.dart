import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';

class TextWidgets extends StatelessWidget {
  final String name;
  final String id;
  const TextWidgets({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.grey),
          ),
          const Spacer(),
          SizedBox(
            width: 180.w,
            child: Text(
              id,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
