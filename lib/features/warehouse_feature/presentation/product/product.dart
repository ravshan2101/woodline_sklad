import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
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
  @override
  void initState() {
    context.read<ProductProvider>().getProduct();
    super.initState();
  }

  Future _onRefresh() async {
    await context.read<ProductProvider>().getProduct();
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProductProvider>(context, listen: true);
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
                onchaged: (value) {
                  data.searchProduct(id: value);
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (data.productrState == ProductrState.listbosh)
            Center(
              child: Text('Нет информации',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp)),
            )
          else if (data.productrState == ProductrState.loading)
            const Center(
                child: CircularProgressIndicator(color: AppColors.blue))
          else if (data.productrState == ProductrState.loaded)
            Expanded(
                child: RefreshIndicator(
              color: AppColors.blue,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: data.listproduct.length,
                itemBuilder: (context, index) {
                  return ProductCardWidget(
                    orderId: data.listproduct[index]!.orderId,
                    whereHouseId: data.listproduct[index]!.warehouseId,
                    status: data.listproduct[index]!.order!.status == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.status!,
                    id: data.listproduct[index]!.order!.orderId == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.orderId.toString(),
                    model: data.listproduct[index]!.order!.model == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.model!.name,
                    quantity: data.listproduct[index]!.order!.qty == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.qty.toString(),
                    tissue: data.listproduct[index]!.order!.tissue == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.tissue!,
                    cost: data.listproduct[index]!.order!.cost == null
                        ? 'Нет информации'
                        : data.listproduct[index]!.order!.cost!,
                    sell: data.listproduct[index]!.order!.sale == null
                        ? "Нет информации"
                        : double.parse(data.listproduct[index]!.order!.sale!)
                            .toStringAsFixed(2)
                            .toString(),
                    title: data.listproduct[index]!.order!.title == null
                        ? "Нет информации"
                        : data.listproduct[index]!.order!.title!,
                    price: data.listproduct[index]!.order!.sum == null
                        ? "Нет информации"
                        : data.listproduct[index]!.order!.sum!,
                    onTab: () async {
                      Navigator.of(context).pop();
                      await ProduktRepository().putProduct(
                          id: data.listproduct[index]!.orderId!,
                          status: "ACTIVE");
                      data.getProduct();
                    },
                    onTabBrak: () async {
                      Navigator.of(context).pop();
                      await ProduktRepository().putProduct(
                          id: data.listproduct[index]!.orderId!,
                          status: "DEFECTED");
                      data.getProduct();
                    },
                    onTabOtpvraka: () async {
                      Navigator.of(context).pop();
                      await ProduktRepository().putProduct(
                          id: data.listproduct[index]!.orderId!,
                          status: "DELIVERED");
                      data.getProduct();
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
