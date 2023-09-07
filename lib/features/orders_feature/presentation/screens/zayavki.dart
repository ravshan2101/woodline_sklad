import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/orders_feature/presentation/provider/zayavki_provider.dart';
import 'package:woodline_sklad/features/orders_feature/repository/zayavkiRepository.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ZayavkiScreen extends StatefulWidget {
  const ZayavkiScreen({super.key});

  @override
  State<ZayavkiScreen> createState() => _ZayavkiScreenState();
}

class _ZayavkiScreenState extends State<ZayavkiScreen> {
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    final data = context.read<ZayavkiProvider>();
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
          title: 'Заявки',
          appbarBottom: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFieldWidget(
              onchaged: (p0) async {
                final result = await ZayavkiRepository().getZayavkiSearch(p0);
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
          isbottomHas: true,
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
                                        offset: const Offset(0, 3))
                                  ],
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidgets(
                                        name: 'ID',
                                        id: item!.order!.orderId == null
                                            ? "Нет информации"
                                            : item!.order!.orderId!),
                                    TextWidgets(
                                        name: 'Модел',
                                        id: item!.order!.model == null
                                            ? "Нет информации"
                                            : item!.order!.model!.name!),
                                    TextWidgets(
                                        name: 'Кол-во',
                                        id: item!.order!.qty == null
                                            ? "Нет информации"
                                            : item!.order!.qty.toString()),
                                    TextWidgets(
                                        name: 'Ткань',
                                        id: item!.order!.tissue == null
                                            ? "Нет информации"
                                            : item!.order!.tissue!),
                                    TextWidgets(
                                        name: 'Цена',
                                        id: item!.order!.cost == null
                                            ? "Нет информации"
                                            : item!.order!.cost!),
                                    TextWidgets(
                                        name: 'Распродажа',
                                        id: item!.order!.sale == null
                                            ? "Нет информации"
                                            : '${double.parse(item!.order!.sale!).toStringAsFixed(2)} %'),
                                    TextWidgets(
                                        name: 'Заголовок',
                                        id: item!.order!.title == null
                                            ? "Нет информации"
                                            : item!.order!.title!),
                                    TextWidgets(
                                        name: 'Сумма',
                                        id: item!.order!.sum == null
                                            ? "Нет информации"
                                            : '${item!.order!.sum.toString()} сум'),
                                    ScreenUtil().setVerticalSpacing(10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        color: AppColors.blue,
                                        onPressed: () async {
                                          if (item!.orderId != null) {
                                            debugPrint(item.orderId);
                                            ProduktRepository().putProduct(
                                                id: item.orderId,
                                                status: 'SOLD_AND_CHECKED');
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
                                        child: const Text(
                                          'Я видел',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ]));
                        })),
              ),
            ),
            ScreenUtil().setVerticalSpacing(100)
          ],
        ));
  }
}
