import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/dastavleniya.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/product/product.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/transfery/transfery.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/zayavki.dart';

import '../../../../app_const/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;
  List<Widget> bottomList = [
    const ProduktScreen(),
    const TranferyScreen(),
    const ZayavkiScreen(),
    const DastavleniyaScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: bottomList[selectIndex],
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: GNav(
              tabBorderRadius: 20,
              tabBackgroundColor: AppColors.blue,
              activeColor: AppColors.white,
              backgroundColor: AppColors.white,
              gap: 8,
              padding: EdgeInsets.all(10.w),
              tabs: const [
                GButton(icon: CupertinoIcons.asterisk_circle, text: 'Продукты'),
                GButton(icon: CupertinoIcons.person, text: 'Трансферы'),
                GButton(icon: CupertinoIcons.cart, text: 'Заявки'),
                GButton(icon: CupertinoIcons.settings, text: 'Даставленные')
              ],
              selectedIndex: selectIndex,
              onTabChange: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
