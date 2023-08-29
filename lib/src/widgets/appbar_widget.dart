import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget>? actions;
  final Widget? appbarBottom;
  final bool isbottomHas;
  const AppbarWidget(
      {super.key,
      required this.title,
      this.isbottomHas = false,
      this.actions,
      this.appbarBottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: isbottomHas
          ? PreferredSize(
              preferredSize: const Size(double.infinity, 56),
              child: appbarBottom!)
          : null,
      actions: actions,
      centerTitle: true,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size(double.infinity, isbottomHas ? 112.h : 56.h);
}
