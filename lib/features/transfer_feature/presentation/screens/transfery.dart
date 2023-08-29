import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/provider/transfer_provider.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/widgets/choosButton.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class TranferyScreen extends StatefulWidget {
  const TranferyScreen({super.key});

  @override
  State<TranferyScreen> createState() => _TranferyScreenState();
}

class _TranferyScreenState extends State<TranferyScreen> {
  @override
  void initState() {
    context.read<TransferProvider>().getTranfer();
    super.initState();
  }

  Future _onRefresh() async {
    await context.read<TransferProvider>().getTranfer();
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<TransferProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        appbarBottom: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFieldWidget(
            cursorHeight: 20.h,
            name: 'Поиск..',
            icon: const Icon(CupertinoIcons.search),
            vertical: 8,
            onchaged: (value) {
              data.getSearch(value);
            },
          ),
        ),
        title: 'Трансферы',
        isbottomHas: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (data.transferState == TransferState.listbosh)
          Center(
            child: Text('Нет информации',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp)),
          )
        else if (data.transferState == TransferState.loading)
          const Center(child: CircularProgressIndicator(color: AppColors.blue))
        else if (data.transferState == TransferState.loaded)
          Expanded(
              child: RefreshIndicator(
                  color: AppColors.blue,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: data.list.length,
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
                                  color: AppColors.blue.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                )
                              ],
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(children: [
                            TextWidgets(
                                name: 'ID: ',
                                id: data.list[index]!.order!.orderId == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.orderId!),
                            TextWidgets(
                                name: 'Модел',
                                id: data.list[index]!.order!.model == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.model!.name!),
                            TextWidgets(
                                name: 'Кол-во',
                                id: data.list[index]!.order!.qty == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.qty.toString()),
                            TextWidgets(
                                name: 'Ткань',
                                id: data.list[index]!.order!.tissue == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.tissue!),
                            TextWidgets(
                                name: 'Цена',
                                id: data.list[index]!.order!.cost == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.cost!),
                            TextWidgets(
                                name: 'Распродажа',
                                id: data.list[index]!.order!.sale == null
                                    ? "Нет информации"
                                    : '${double.parse(data.list[index]!.order!.sale!).toStringAsFixed(2)} %'),
                            TextWidgets(
                                name: 'Заголовок',
                                id: data.list[index]!.order!.title == null
                                    ? "Нет информации"
                                    : data.list[index]!.order!.title!),
                            TextWidgets(
                                name: 'Сумма',
                                id: data.list[index]!.order!.sum == null
                                    ? "Нет информации"
                                    : '${data.list[index]!.order!.sum} сум'),
                            ScreenUtil().setVerticalSpacing(10),
                            ChooseButton(
                              id: data.list[index]!.orderId!,
                              onPressedActive: () async {
                                Navigator.of(context).pop();
                                await ProduktRepository().putProduct(
                                    id: data.list[index]!.orderId!,
                                    status: 'ACTIVE');
                                data.getTranfer();
                              },
                              onPressedDefected: () async {
                                Navigator.of(context).pop();
                                await ProduktRepository().putProduct(
                                    id: data.list[index]!.orderId!,
                                    status: 'DEFECTED');
                                data.getTranfer();
                              },
                            ),
                          ]),
                        );
                      }))),
        ScreenUtil().setVerticalSpacing(100)
      ]),
    );
  }
}
