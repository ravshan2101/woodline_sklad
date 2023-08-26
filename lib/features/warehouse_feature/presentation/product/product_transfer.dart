import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_skladItems_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

class ProduktTransfer extends StatefulWidget {
  const ProduktTransfer({super.key});

  @override
  State<ProduktTransfer> createState() => _ProduktTransferState();
}

class _ProduktTransferState extends State<ProduktTransfer> {
  @override
  void initState() {
    getSklad();
    super.initState();
  }

  String? selected;
  List<TransferSkladItems?> sklad = [];

  Future<void> getSklad() async {
    sklad = await ProduktRepository().getSklad();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TransferM;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: const Text(
          'Перенести продукт',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: sklad.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'выбрать компанию',
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
                      hint: const Text('Tanlang'),
                      value: selected,
                      items: List.generate(
                        sklad.length,
                        (index) => DropdownMenuItem(
                            value: sklad[index]!.id!,
                            child: Text(sklad[index]!.name == null
                                ? "blllaaaa null ku"
                                : sklad[index]!.name!)),
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
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.white,
                        ),
                        offset: const Offset(0, -4),
                      ),
                      menuItemStyleData: MenuItemStyleData(height: 36.h),
                      underline: const SizedBox(),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        TextWidgets(name: 'ID ЗАКАЗA:', id: args.id!),
                        TextWidgets(name: 'МОДЕЛ:', id: args.model!),
                        TextWidgets(name: 'КОЛ-ВО:', id: args.quantity!),
                        TextWidgets(name: 'ТКАН:', id: args.tissue!),
                        TextWidgets(name: 'ЦЕНА:', id: args.cost!),
                        TextWidgets(name: 'РАСПРОДАЖА:', id: args.sell!),
                        TextWidgets(name: 'ЗАГОЛОВОК:', id: args.title!),
                        TextWidgets(name: 'СУММА:', id: args.price!),
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
                                msg: 'sklad tanlang',
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
    );
  }
}
