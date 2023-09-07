import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/provider/transfer_provider.dart';

import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/card_widget.dart';
import 'package:woodline_sklad/features/warehouse_feature/provider/product_getProvider.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ProduktScreen extends StatefulWidget {
  const ProduktScreen({super.key});
  @override
  State<ProduktScreen> createState() => _ProduktScreenState();
}

class _ProduktScreenState extends State<ProduktScreen> {
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    final data = Provider.of<ProductProvider>(context, listen: false);

    pagingController.addPageRequestListener((pageKey) {
      data.fetchPage(pageKey, pagingController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        isbottomHas: true,
        title: 'Продукты',
        appbarBottom: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFieldWidget(
                  cursorHeight: 20.h,
                  name: 'Поиск..',
                  icon: const Icon(CupertinoIcons.search),
                  vertical: 8,
                  onchaged: (value) async {
                    final result =
                        await ProduktRepository().getSearchGl(id: value);
                    final newList = result!.products!;
                    pagingController.itemList = newList;
                    setState(() {});
                  },
                ),
              ),
              ScreenUtil().setHorizontalSpacing(10),
              Container(
                height: 40.h,
                width: 130.w,
                decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(10.r)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.produckrAction);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  child: const Text(
                    'Добавить',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    surfaceTintColor: AppColors.white,
                    title: const Text('Выйти?'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.auth,
                                (Route<dynamic> route) => false);
                            await AuhtLocalData().removeToken();
                          },
                          child: const Text('Выйти',
                              style: TextStyle(color: AppColors.black))),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Закрывать',
                            style: TextStyle(color: AppColors.black)),
                      )
                    ],
                  );
                },
              );
            },
            splashRadius: 24.r,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: AppColors.blue,
            iconSize: 24.sp,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: RefreshIndicator(
            color: AppColors.blue,
            onRefresh: () => Future.sync(() => pagingController.refresh()),
            child: PagedListView(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) {
                    return ProductCardWidget(
                      orderId: item.orderId!,
                      whereHouseId: item.warehouseId,
                      status: item.order!.status == null
                          ? 'Нет информации'
                          : item.order!.status!,
                      id: item.order!.orderId == null
                          ? 'Нет информации'
                          : item.order!.orderId.toString(),
                      model: item.order!.model == null
                          ? 'Нет информации'
                          : item.order!.model!.name,
                      quantity: item.order!.qty == null
                          ? 'Нет информации'
                          : item.order!.qty.toString(),
                      tissue: item.order!.tissue == null
                          ? 'Нет информации'
                          : item.order!.tissue!,
                      cost: item.order!.cost == null
                          ? 'Нет информации'
                          : item.order!.cost!,
                      sell: item.order!.sale == null
                          ? "Нет информации"
                          : double.parse(item.order!.sale!)
                              .toStringAsFixed(2)
                              .toString(),
                      title: item.order!.title == null
                          ? "Нет информации"
                          : item.order!.title!,
                      price: item.order!.sum == null
                          ? "Нет информации"
                          : item.order!.sum!,
                      onTab: () async {
                        Navigator.of(context).pop();
                        final updateActive = await ProduktRepository()
                            .putProduct(id: item.orderId!, status: "ACTIVE");
                        debugPrint(updateActive!.order!.orderId!);
                        setState(() {
                          pagingController.itemList![index] = updateActive;
                        });
                        debugPrint(updateActive.order!.status.toString() +
                            item.order!.status.toString());
                      },
                      onTabBrak: () async {
                        Navigator.of(context).pop();
                        final updateActive = await ProduktRepository()
                            .putProduct(id: item.orderId!, status: "DEFECTED");
                        setState(() {
                          pagingController.itemList![index] = updateActive!;
                        });
                      },
                      onTabOtpvraka: () async {
                        Navigator.of(context).pop();
                        final updateActive = await ProduktRepository()
                            .putProduct(id: item.orderId!, status: "DELIVERED");
                        if (updateActive!.order!.status == "DELIVERED") {
                          setState(() {
                            pagingController.itemList!.removeAt(index);
                          });
                        }
                      },
                    );
                  },
                )),
          )),
          ScreenUtil().setVerticalSpacing(90),
        ],
      ),
    );
  }
}

class TransferM {
  final String? id;
  final String? model;
  final String? quantity;
  final String? tissue;
  final String? cost;
  final String? sell;
  final String? title;
  final String? price;
  final String? orderId;
  final String? whereHouseId;

  TransferM({
    required this.id,
    required this.model,
    required this.quantity,
    required this.tissue,
    required this.cost,
    required this.sell,
    required this.title,
    required this.price,
    this.orderId,
    this.whereHouseId,
  });
}
