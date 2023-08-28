import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';

import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/card_widget.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';

import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ProduktScreen extends StatefulWidget {
  const ProduktScreen({super.key});

  @override
  State<ProduktScreen> createState() => _ProduktScreenState();
}

class _ProduktScreenState extends State<ProduktScreen> {
  String? selectValue;
  bool isLoading = false;
  ProductsModel? productsModel;
  ProductsModel? productsSearch;
  String? id;
  List<Product?> listproduct = [];

  Future<void> getProduct() async {
    isLoading = true;
    productsModel = await ProduktRepository().getProduckt();

    listproduct = productsModel!.products!;

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        title: 'Продукты',
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
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.auth);
                            await AuhtLocalData().removeToken();
                          },
                          child: const Text(
                            'Выйти',
                            style: TextStyle(color: AppColors.black),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Закрывать',
                          style: TextStyle(color: AppColors.black),
                        ),
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
        children: [
          ScreenUtil().setVerticalSpacing(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
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
                    productsSearch =
                        await ProduktRepository().getSearchGl(id: value);
                    listproduct = productsSearch!.products!;
                    setState(() {});
                  },
                )),
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
          ScreenUtil().setVerticalSpacing(10),
          isLoading == true
              ? const CircularProgressIndicator(color: AppColors.blue)
              : Expanded(
                  child: RefreshIndicator(
                  color: AppColors.blue,
                  onRefresh: () async {
                    await getProduct();
                  },
                  child: ListView.builder(
                    itemCount: listproduct.length,
                    itemBuilder: (context, index) {
                      return ProductCardWidget(
                        orderId: productsModel!.products![index].orderId,
                        whereHouseId:
                            productsModel!.products![index].warehouseId,
                        status: productsModel!.products![index].order!.status ==
                                null
                            ? 'Malumot yoq'
                            : productsModel!.products![index].order!.status!,
                        id: productsModel!.products![index].order!.orderId ==
                                null
                            ? 'Malumot yoq'
                            : productsModel!.products![index].order!.orderId
                                .toString(),
                        model:
                            productsModel!.products![index].order!.model == null
                                ? 'Malumot yoq'
                                : productsModel!
                                    .products![index].order!.model!.name,
                        quantity:
                            productsModel!.products![index].order!.qty == null
                                ? 'Malumot yoq'
                                : productsModel!.products![index].order!.qty
                                    .toString(),
                        tissue: productsModel!.products![index].order!.tissue ==
                                null
                            ? 'Malumot yoq'
                            : productsModel!.products![index].order!.tissue!,
                        cost:
                            productsModel!.products![index].order!.cost == null
                                ? 'Malumot yoq'
                                : productsModel!.products![index].order!.cost!,
                        sell:
                            productsModel!.products![index].order!.sale == null
                                ? "Malumot yo'q"
                                : double.parse(productsModel!
                                        .products![index].order!.sale!)
                                    .toStringAsFixed(2)
                                    .toString(),
                        title:
                            productsModel!.products![index].order!.title == null
                                ? "Malumot yo'q"
                                : productsModel!.products![index].order!.title!,
                        price:
                            productsModel!.products![index].order!.sum == null
                                ? "Malumot yo'q"
                                : productsModel!.products![index].order!.sum!,
                        onTab: () async {
                          Navigator.of(context).pop();
                          await ProduktRepository().putProduct(
                              id: productsModel!.products![index].orderId!,
                              status: "ACTIVE");
                          await getProduct();
                        },
                        onTabBrak: () async {
                          Navigator.of(context).pop();
                          await ProduktRepository().putProduct(
                              id: productsModel!.products![index].orderId!,
                              status: "DEFECTED");
                          await getProduct();
                        },
                        onTabOtpvraka: () async {
                          Navigator.of(context).pop();
                          await ProduktRepository().putProduct(
                              id: productsModel!.products![index].orderId!,
                              status: "DELIVERED");
                          await getProduct();
                        },
                      );
                    },
                  ),
                )),
          ScreenUtil().setVerticalSpacing(100),
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
