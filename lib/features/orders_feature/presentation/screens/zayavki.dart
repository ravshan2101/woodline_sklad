import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/orders_feature/presentation/provider/zayavki_provider.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ZayavkiScreen extends StatefulWidget {
  const ZayavkiScreen({super.key});

  @override
  State<ZayavkiScreen> createState() => _ZayavkiScreenState();
}

class _ZayavkiScreenState extends State<ZayavkiScreen> {
  @override
  void initState() {
    context.read<ZayavkiProvider>().getZayavki();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ZayavkiProvider>(context, listen: true);

    Future _onRefresh() async {
      await context.read<ZayavkiProvider>().getZayavki();
      return Future.delayed(const Duration(milliseconds: 300));
    }

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AppbarWidget(title: 'Заявки'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: TextFieldWidget(
                onchaged: (p0) {
                  data.getSearch(p0);
                },
                cursorHeight: 20.h,
                name: 'Поиск..',
                icon: const Icon(CupertinoIcons.search),
                vertical: 8,
              ),
            ),
            if (data.zayavkiState == ZayavkiState.listbosh)
              Center(
                child: Text('Нет информации',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp)),
              )
            else if (data.zayavkiState == ZayavkiState.loading)
              const CircularProgressIndicator(color: AppColors.blue)
            else if (data.zayavkiState == ZayavkiState.loaded)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.blue,
                  child: ListView.builder(
                      itemCount: data.zayavkiGetList.length,
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
                                      color: AppColors.blue.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 0))
                                ],
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidgets(
                                      name: 'ID: ',
                                      id: data.zayavkiGetList[index]!.order!
                                          .orderId!
                                          .toString()),
                                  TextWidgets(
                                      name: 'МОДЕЛ: ',
                                      id: data.zayavkiGetList[index]!.order!
                                          .model!.name!),
                                  TextWidgets(
                                      name: 'КОЛ-ВО: ',
                                      id: data.zayavkiGetList[index]!.order!.qty
                                          .toString()),
                                  TextWidgets(
                                      name: 'ТКАНЬ: ',
                                      id: data
                                          .zayavkiGetList[index]!.order!.tissue!
                                          .toString()),
                                  TextWidgets(
                                      name: 'ЦЕНА: ',
                                      id: data
                                          .zayavkiGetList[index]!.order!.cost!
                                          .toString()),
                                  TextWidgets(
                                      name: 'РАСПРОДАЖА: ',
                                      id: '${double.parse(data.zayavkiGetList[index]!.order!.sale!).toStringAsFixed(2)} %'),
                                  TextWidgets(
                                      name: 'ЗАГОЛОВОК: ',
                                      id: data
                                          .zayavkiGetList[index]!.order!.title
                                          .toString()),
                                  TextWidgets(
                                      name: 'СУММА: ',
                                      id: '${data.zayavkiGetList[index]!.order!.sum.toString()} сум'),
                                  ScreenUtil().setVerticalSpacing(10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      color: AppColors.blue,
                                      onPressed: () {
                                        data.putZayavki(data
                                            .zayavkiGetList[index]!.orderId!);
                                        data.getZayavki();
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
                      }),
                ),
              ),
            ScreenUtil().setVerticalSpacing(100)
          ],
        ));
  }
}
