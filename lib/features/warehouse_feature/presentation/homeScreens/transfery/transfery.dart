import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homeScreens/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class TranferyScreen extends StatefulWidget {
  const TranferyScreen({super.key});

  @override
  State<TranferyScreen> createState() => _TranferyScreenState();
}

class _TranferyScreenState extends State<TranferyScreen> {
  List<String> items = [
    'Гатова',
    'Брак',
  ];
  String? select;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Трансферы',
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
              child: TextFieldWidget(
                cursorHeight: 14.h,
                name: 'Search',
                icon: const Icon(CupertinoIcons.search),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  SizedBox(
                                    child: DropdownButton2(
                                      hint: const Text('Выбрать статус'),
                                      value: select,
                                      items: List.generate(
                                          items.length,
                                          (index) => DropdownMenuItem(
                                                value: items[index],
                                                child: Text(items[index]),
                                              )),
                                      onChanged: (value) {
                                        setState(() {
                                          select = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 36.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border:
                                              Border.all(color: AppColors.grey),
                                          color: AppColors.white,
                                        ),
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          CupertinoIcons.chevron_down,
                                          color: AppColors.grey,
                                        ),
                                        iconSize: 16.h,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        padding: EdgeInsets.zero,
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColors.white,
                                        ),
                                        offset: const Offset(0, -4),
                                      ),
                                      menuItemStyleData:
                                          MenuItemStyleData(height: 36.h),
                                      underline: const SizedBox(),
                                    ),
                                  )
                                ],
                              ),
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
                            ]));
                  }),
            ),
          ],
        ));
  }
}
