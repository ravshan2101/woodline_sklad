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

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<TransferProvider>(context, listen: true);
    Future _onRefresh() async {
      await context.read<TransferProvider>().getTranfer();
      return Future.delayed(const Duration(milliseconds: 300));
    }

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
                              vertical: 8.h, horizontal: 20.w),
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
                          child: Column(children: [
                            TextWidgets(
                                name: 'ID: ',
                                id: data.list[index]!.order!.orderId!
                                    .toString()),
                            TextWidgets(
                                name: 'МОДЕЛ: ',
                                id: data.list[index]!.order!.model!.name!),
                            TextWidgets(
                                name: 'КОЛ-ВО: ',
                                id: data.list[index]!.order!.qty.toString()),
                            TextWidgets(
                                name: 'ТКАНЬ: ',
                                id: data.list[index]!.order!.tissue!
                                    .toString()),
                            TextWidgets(
                                name: 'ЦЕНА: ',
                                id: data.list[index]!.order!.cost!.toString()),
                            TextWidgets(
                                name: 'РАСПРОДАЖА: ',
                                id: '${double.parse(data.list[index]!.order!.sale!).toStringAsFixed(2)} %'),
                            TextWidgets(
                                name: 'ЗАГОЛОВОК: ',
                                id: data.list[index]!.order!.title.toString()),
                            TextWidgets(
                                name: 'СУММА: ',
                                id: '${data.list[index]!.order!.sum.toString()} сум'),
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
