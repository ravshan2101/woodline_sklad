import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future _onRefresh() async {
    await context.read<ZayavkiProvider>().getZayavki();
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ZayavkiProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppbarWidget(
          title: 'Заявки',
          appbarBottom: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          isbottomHas: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (data.zayavkiState == ZayavkiState.listbosh)
              Center(
                child: Text('Нет информации',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp)),
              )
            else if (data.zayavkiState == ZayavkiState.loading)
              const Center(
                  child: CircularProgressIndicator(color: AppColors.blue))
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
                                      id: data.zayavkiGetList[index]!.order!
                                                  .orderId ==
                                              null
                                          ? "Нет информации"
                                          : data.zayavkiGetList[index]!.order!
                                              .orderId!),
                                  TextWidgets(
                                      name: 'Модел',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .model ==
                                              null
                                          ? "Нет информации"
                                          : data.zayavkiGetList[index]!.order!
                                              .model!.name!),
                                  TextWidgets(
                                      name: 'Кол-во',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .qty ==
                                              null
                                          ? "Нет информации"
                                          : data
                                              .zayavkiGetList[index]!.order!.qty
                                              .toString()),
                                  TextWidgets(
                                      name: 'Ткань',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .tissue ==
                                              null
                                          ? "Нет информации"
                                          : data.zayavkiGetList[index]!.order!
                                              .tissue!),
                                  TextWidgets(
                                      name: 'Цена',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .cost ==
                                              null
                                          ? "Нет информации"
                                          : data.zayavkiGetList[index]!.order!
                                              .cost!),
                                  TextWidgets(
                                      name: 'Распродажа',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .sale ==
                                              null
                                          ? "Нет информации"
                                          : '${double.parse(data.zayavkiGetList[index]!.order!.sale!).toStringAsFixed(2)} %'),
                                  TextWidgets(
                                      name: 'Заголовок',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .title ==
                                              null
                                          ? "Нет информации"
                                          : data.zayavkiGetList[index]!.order!
                                              .title!),
                                  TextWidgets(
                                      name: 'Сумма',
                                      id: data.zayavkiGetList[index]!.order!
                                                  .sum ==
                                              null
                                          ? "Нет информации"
                                          : '${data.zayavkiGetList[index]!.order!.sum.toString()} сум'),
                                  ScreenUtil().setVerticalSpacing(10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      color: AppColors.blue,
                                      onPressed: () async {
                                        if (data.zayavkiGetList[index]!
                                                .orderId !=
                                            null) {
                                          await data.putZayavki(data
                                              .zayavkiGetList[index]!.orderId!);
                                        } else {
                                          Fluttertoast.showToast(
                                              timeInSecForIosWeb: 2,
                                              gravity: ToastGravity.TOP,
                                              msg: 'Ордер ид нулл',
                                              textColor: AppColors.white,
                                              fontSize: 16,
                                              backgroundColor: AppColors.grey);
                                        }
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
