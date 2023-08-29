import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/condition_widget.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';

class ProductCardWidget extends StatelessWidget {
  final String? id;
  final String? model;
  final String? quantity;
  final String? tissue;
  final String? cost;
  final String? sell;
  final String? title;
  final String? price;
  final String? status;
  final String? orderId;
  final String? whereHouseId;
  final VoidCallback onTab;
  final VoidCallback onTabBrak;
  final VoidCallback onTabOtpvraka;

  const ProductCardWidget(
      {super.key,
      required this.id,
      required this.model,
      required this.quantity,
      required this.tissue,
      required this.cost,
      required this.sell,
      required this.title,
      required this.price,
      required this.status,
      required this.onTab,
      required this.onTabBrak,
      required this.onTabOtpvraka,
      this.orderId,
      this.whereHouseId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.blue.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ], color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == "ACTIVE")
            const ConditionWidget(
                icon: CupertinoIcons.check_mark_circled_solid,
                color: Colors.green,
                text: 'Готова'),
          if (status == "DEFECTED")
            const ConditionWidget(
                icon: CupertinoIcons.exclamationmark_circle_fill,
                color: Colors.red,
                text: 'Брак'),
          if (status == "SOLD_AND_CHECKED")
            const ConditionWidget(
                icon: CupertinoIcons.info_circle_fill,
                color: Colors.blue,
                text: 'К отправке'),
          if (status == "RETURNED")
            const ConditionWidget(
                icon: CupertinoIcons.exclamationmark_circle_fill,
                color: Colors.orange,
                text: 'Возврат'),
          ScreenUtil().setVerticalSpacing(5),
          TextWidgets(name: 'ID: ', id: id!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Модел', id: model!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Кол-во', id: quantity!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Ткань', id: tissue!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Цена', id: cost!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Распродажа', id: "${(sell)} %"),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Заголовок', id: title!),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 0.6,
              width: double.infinity,
              color: Colors.grey),
          TextWidgets(name: 'Сумма', id: '$price сум'),
          ScreenUtil().setVerticalSpacing(10),
          Container(
            height: 40.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(10.r)),
            child: MaterialButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          status == "SOLD_AND_CHECKED"
                              ? const SizedBox.shrink()
                              : TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.produktTransfer,
                                        arguments: TransferM(
                                            id: id,
                                            model: model,
                                            quantity: quantity,
                                            tissue: tissue,
                                            cost: cost,
                                            sell: sell,
                                            title: title,
                                            price: price,
                                            orderId: orderId,
                                            whereHouseId: whereHouseId));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(CupertinoIcons.share_solid,
                                          color: Colors.orange),
                                      ScreenUtil().setHorizontalSpacing(10),
                                      Text('Трансферы',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16.sp)),
                                    ],
                                  )),
                          status == "ACTIVE" || status == "SOLD_AND_CHECKED"
                              ? const SizedBox.shrink()
                              : TextButton(
                                  onPressed: onTab,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                          CupertinoIcons.checkmark_circle_fill,
                                          color: Colors.green),
                                      ScreenUtil().setHorizontalSpacing(10),
                                      Text('Готова',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16.sp)),
                                    ],
                                  )),
                          status == "DEFECTED" ||
                                  status == "SOLD_AND_CHECKED" ||
                                  status == "DELIVERED" ||
                                  status == "RETURNED"
                              ? const SizedBox.shrink()
                              : TextButton(
                                  onPressed: onTabBrak,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                          CupertinoIcons
                                              .exclamationmark_circle_fill,
                                          color: Colors.red),
                                      ScreenUtil().setHorizontalSpacing(10),
                                      Text('Брак',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16.sp)),
                                    ],
                                  )),
                          status == "ACTIVE" ||
                                  status == "DEFECTED" ||
                                  status == "DELIVERED" ||
                                  status == "RETURNED"
                              ? const SizedBox.shrink()
                              : TextButton(
                                  onPressed: onTabOtpvraka,
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.car_fill,
                                          color: Colors.blue),
                                      ScreenUtil().setHorizontalSpacing(10),
                                      Text('Доставлена',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16.sp)),
                                    ],
                                  ))
                        ],
                      ),
                    );
                  },
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: const Center(
                child: Text(
                  'Изменить',
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
