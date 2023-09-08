import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/delivery_feature/presentation/provider/delivery_provider.dart';
import 'package:woodline_sklad/features/delivery_feature/presentation/widgets/yesOrNowidgets.dart';
import 'package:woodline_sklad/features/delivery_feature/repository/delivered_repo.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class Dastavleniya extends StatefulWidget {
  const Dastavleniya({super.key});

  @override
  State<Dastavleniya> createState() => _DastavleniyaState();
}

class _DastavleniyaState extends State<Dastavleniya> {
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    final data = context.read<DeliveredProvider>();
    pagingController.addPageRequestListener((pageKey) {
      data.fetchPage(pageKey, pagingController);
    });

    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppbarWidget(
          isbottomHas: true,
          title: 'Даставленния',
          appbarBottom: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFieldWidget(
              onchaged: (p0) async {
                final result =
                    await DeliveredRepository().getDeleviredSearch(p0);
                final newList = result!.products!;
                pagingController.itemList = newList;
                setState(() {});
              },
              cursorHeight: 20.h,
              name: 'Поиск..',
              icon: const Icon(CupertinoIcons.search),
              vertical: 8,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future(() => pagingController.refresh()),
                color: AppColors.blue,
                child: PagedListView(
                    pagingController: pagingController,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blue.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidgets(
                                        name: 'ID',
                                        id: item.order!.orderId == null
                                            ? "Нет информации"
                                            : item.order!.orderId!),
                                    TextWidgets(
                                        name: 'Модел',
                                        id: item.order!.model == null
                                            ? "Нет информации"
                                            : item.order!.model!.name!),
                                    TextWidgets(
                                        name: 'Кол-во',
                                        id: item.order!.qty == null
                                            ? "Нет информации"
                                            : item.order!.qty.toString()),
                                    TextWidgets(
                                        name: 'Ткань',
                                        id: item.order!.tissue == null
                                            ? "Нет информации"
                                            : item.order!.tissue!),
                                    TextWidgets(
                                        name: 'Цена',
                                        id: item.order!.cost == null
                                            ? "Нет информации"
                                            : item.order!.cost!),
                                    TextWidgets(
                                        name: 'Распродажа',
                                        id: item.order!.sale == null
                                            ? "Нет информации"
                                            : '${double.parse(item.order!.sale!).toStringAsFixed(2)} %'),
                                    TextWidgets(
                                        name: 'Заголовок',
                                        id: item.order!.title == null
                                            ? "Нет информации"
                                            : item.order!.title!),
                                    TextWidgets(
                                        name: 'Сумма',
                                        id: item.order!.sum == null
                                            ? "Нет информации"
                                            : '${item.order!.sum.toString()} сум'),
                                    ScreenUtil().setVerticalSpacing(10),
                                    ReturnButon(
                                        idModel: item.order!.orderId.toString(),
                                        modelName:
                                            item.order!.model.name.toString(),
                                        tkanModel:
                                            item.order!.tissue.toString(),
                                        id: item.orderId,
                                        onPressedActive: () async {
                                          Navigator.of(context).pop();
                                          if (item.orderId != null) {
                                            await ProduktRepository()
                                                .putProduct(
                                                    id: item.orderId,
                                                    status: 'RETURNED');
                                            setState(() {
                                              pagingController.itemList!
                                                  .removeAt(index);
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                timeInSecForIosWeb: 2,
                                                gravity: ToastGravity.TOP,
                                                msg: 'Ордер ид нулл',
                                                textColor: AppColors.white,
                                                fontSize: 16,
                                                backgroundColor:
                                                    AppColors.grey);
                                          }
                                        },
                                        onPressedDefected: () {
                                          Navigator.of(context).pop();
                                        })
                                  ]));
                        })),
              ),
            ),
            ScreenUtil().setVerticalSpacing(100)
          ],
        ));
  }
}
