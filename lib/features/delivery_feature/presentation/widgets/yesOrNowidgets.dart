import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';

class ReturnButon extends StatelessWidget {
  final String id;
  final String idModel;
  final String modelName;
  final String tkanModel;
  final VoidCallback onPressedActive;
  final VoidCallback onPressedDefected;

  const ReturnButon({
    super.key,
    required this.id,
    required this.onPressedActive,
    required this.onPressedDefected,
    required this.idModel,
    required this.modelName,
    required this.tkanModel,
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
                title: const Text('Возврат ?'),
                backgroundColor: AppColors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID - $idModel",
                      style: const TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Модел - $modelName",
                      style: const TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Ткань - $tkanModel",
                      style: const TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: onPressedActive,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(CupertinoIcons.checkmark_circle_fill,
                                    color: Colors.green),
                                ScreenUtil().setHorizontalSpacing(10),
                                Text('Да',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16.sp)),
                              ],
                            )),
                        TextButton(
                            onPressed: onPressedDefected,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(CupertinoIcons.xmark_circle_fill,
                                    color: Colors.red),
                                ScreenUtil().setHorizontalSpacing(10),
                                Text('Нет',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16.sp)),
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        color: AppColors.blue,
        child: const Text(
          'Возврат',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
