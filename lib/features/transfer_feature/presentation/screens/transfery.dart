import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/provider/transfer_provider.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/widgets/choosButton.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class TranferyScreen extends StatelessWidget {
  const TranferyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<TransferProvider>(context, listen: true);
    data.getTranfer();

    // ignore: no_leading_underscores_for_local_identifiers
    Future _onRefresh() async {
      await context.read<TransferProvider>().getTranfer();
      return Future.delayed(const Duration(milliseconds: 300));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Трансферы',
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: TextFieldWidget(
              cursorHeight: 14.h,
              name: 'Search',
              icon: const Icon(CupertinoIcons.search),
              vertical: 8,
            ),
          ),
          context.watch<TransferProvider>().transferState ==
                  TransferState.loading
              ? const CircularProgressIndicator()
              : Expanded(
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
                                const TextWidgets(name: 'МОДЕЛ: ', id: ''),
                                TextWidgets(
                                    name: 'КОЛ-ВО: ',
                                    id: data.list[index]!.order!.qty
                                        .toString()),
                                TextWidgets(
                                    name: 'ТКАНЬ: ',
                                    id: data.list[index]!.order!.tissue!
                                        .toString()),
                                TextWidgets(
                                    name: 'ЦЕНА: ',
                                    id: data.list[index]!.order!.cost!
                                        .toString()),
                                TextWidgets(
                                    name: 'РАСПРОДАЖА: ',
                                    id: '${context.read<TransferProvider>().list[index]!.order!.sale.toString()} %'),
                                TextWidgets(
                                    name: 'ЗАГОЛОВОК: ',
                                    id: data.list[index]!.order!.title
                                        .toString()),
                                TextWidgets(
                                    name: 'СУММА: ',
                                    id: '${context.read<TransferProvider>().list[index]!.order!.sum.toString()} сум'),
                                ScreenUtil().setVerticalSpacing(10),
                                ChooseButton(
                                  id: context
                                      .read<TransferProvider>()
                                      .list[index]!
                                      .orderId!,
                                  onPressedActive: () async {
                                    Navigator.of(context).pop();
                                    await ProduktRepository().putProduct(
                                        id: data.list[index]!.orderId!,
                                        status: 'ACTIVE');
                                  },
                                  onPressedDefected: () async {
                                    Navigator.of(context).pop();
                                    await ProduktRepository().putProduct(
                                        id: data.list[index]!.orderId!,
                                        status: 'DEFECTED');
                                  },
                                )
                              ]),
                            );
                          })))
        ],
      ),
    );
  }
}
