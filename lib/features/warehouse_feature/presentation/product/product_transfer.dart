import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/provider/choose_provider.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';

class ProduktTransfer extends StatefulWidget {
  const ProduktTransfer({super.key});

  @override
  State<ProduktTransfer> createState() => _ProduktTransferState();
}

class _ProduktTransferState extends State<ProduktTransfer> {
  String? selected;
  @override
  void initState() {
    context.read<ChooseProvider>().getSklad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ChooseProvider>(context, listen: true);
    final args = ModalRoute.of(context)!.settings.arguments as TransferM;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(title: 'Перенести продукт'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (data.chooseState == ChooseState.loading)
            const Center(
                child: CircularProgressIndicator(color: AppColors.blue))
          else if (data.chooseState == ChooseState.loaded)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Выбрать компанию',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: DropdownButton2(
                          barrierColor: Colors.grey.withOpacity(0.5),
                          hint: const Text('Выбирать'),
                          value: selected,
                          items: List.generate(
                            data.sklad.length,
                            (index) => DropdownMenuItem(
                                value: data.sklad[index]!.id!,
                                child: Text(data.sklad[index]!.name == null
                                    ? "Без имени"
                                    : data.sklad[index]!.name!)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selected = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 36.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.grey),
                              color: AppColors.white,
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: const Icon(CupertinoIcons.chevron_down,
                                color: AppColors.grey),
                            iconSize: 16.h,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: EdgeInsets.zero,
                            maxHeight: 200.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white),
                            offset: const Offset(0, -4),
                          ),
                          menuItemStyleData: MenuItemStyleData(height: 36.h),
                          underline: const SizedBox()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        children: [
                          TextWidgets(name: 'ID заказа', id: args.id!),
                          TextWidgets(name: 'Модел', id: args.model!),
                          TextWidgets(name: 'Кол-во', id: args.quantity!),
                          TextWidgets(name: 'Ткан', id: args.tissue!),
                          TextWidgets(name: 'Цена', id: args.cost!),
                          TextWidgets(name: 'Распродажа', id: args.sell!),
                          TextWidgets(name: 'Заголовок', id: args.title!),
                          TextWidgets(name: 'Сумма', id: args.price!)
                        ],
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          color: AppColors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          onPressed: () async {
                            if (selected != null) {
                              Navigator.of(context).pushNamed(AppRoutes.home);
                              await ProduktRepository().putSklad(
                                  orderId: args.orderId!,
                                  whereHouseId: selected!);
                            } else {
                              Fluttertoast.showToast(
                                  timeInSecForIosWeb: 1,
                                  gravity: ToastGravity.TOP,
                                  msg: 'Выберите склад',
                                  textColor: AppColors.white,
                                  fontSize: 16,
                                  backgroundColor: Colors.red);
                            }
                          },
                          child: const Center(
                            child: Text(
                              'Отправять',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                        ScreenUtil().setHorizontalSpacing(10),
                        MaterialButton(
                          color: AppColors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                            child: Text(
                              'Закрывать',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
