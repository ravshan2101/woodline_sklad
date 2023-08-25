import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ZayavkiScreen extends StatelessWidget {
  const ZayavkiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Заявки',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: const TextFieldWidget(
                cursorHeight: 14,
                name: 'search',
                icon: Icon(CupertinoIcons.search),
                vertical: 8,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blue.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0))
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidgets(
                                  name: 'ID: ', id: '12312423424'),
                              const TextWidgets(
                                  name: 'МОДЕЛ: ', id: 'Роксана Премиум'),
                              const TextWidgets(name: 'КОЛ-ВО: ', id: '1'),
                              const TextWidgets(name: 'ТКАНЬ: ', id: '12'),
                              const TextWidgets(name: 'ЦЕНА: ', id: '0'),
                              const TextWidgets(
                                  name: 'РАСПРОДАЖА: ', id: '0 %'),
                              const TextWidgets(name: 'ЗАГОЛОВОК: ', id: '32'),
                              const TextWidgets(name: 'СУММА: ', id: '0 сум'),
                              ScreenUtil().setVerticalSpacing(10),
                              SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  color: AppColors.blue,
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.eye,
                                        color: AppColors.white,
                                      ),
                                      ScreenUtil().setHorizontalSpacing(10),
                                      const Text(
                                        'Я видел',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]));
                  }),
            ),
          ],
        ));
  }
}
