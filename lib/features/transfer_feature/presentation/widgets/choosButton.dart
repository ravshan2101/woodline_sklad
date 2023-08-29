import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';

class ChooseButton extends StatelessWidget {
  final String id;
  final VoidCallback onPressedActive;
  final VoidCallback onPressedDefected;

  const ChooseButton({
    super.key,
    required this.id,
    required this.onPressedActive,
    required this.onPressedDefected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        height: 40.h,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: onPressedActive,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(CupertinoIcons.checkmark_circle_fill,
                                color: Colors.green),
                            ScreenUtil().setHorizontalSpacing(10),
                            Text('Готова',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 16.sp)),
                          ],
                        )),
                    TextButton(
                        onPressed: onPressedDefected,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                color: Colors.red),
                            ScreenUtil().setHorizontalSpacing(10),
                            Text('Брак',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 16.sp)),
                          ],
                        ))
                  ],
                ),
              );
            },
          );
        },
        color: AppColors.blue,
        child: const Text(
          'Изменить',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
