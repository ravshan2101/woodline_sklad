import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/delivery_feature/presentation/provider/delivery_provider.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_widgets/text_widgets.dart';
import 'package:woodline_sklad/src/widgets/appbar_widget.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class Dastavleniya extends StatefulWidget {
  const Dastavleniya({super.key});

  @override
  State<Dastavleniya> createState() => _DastavleniyaState();
}

class _DastavleniyaState extends State<Dastavleniya> {
  @override
  void initState() {
    context.read<DeliveredProvider>().getDelivered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DeliveredProvider>(context, listen: true);
    Future _onRefresh() async {
      await context.read<DeliveredProvider>().getDelivered();
      return Future.delayed(const Duration(milliseconds: 300));
    }

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AppbarWidget(title: 'Даставленния'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: TextFieldWidget(
                onchaged: (p0) {},
                cursorHeight: 20.h,
                name: 'Поиск..',
                icon: const Icon(CupertinoIcons.search),
                vertical: 8,
              ),
            ),
            if (data.deliveredState == DeliveredState.listbosh)
              Text('Нет информации',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp))
            else if (data.deliveredState == DeliveredState.loading)
              const CircularProgressIndicator(color: AppColors.blue)
            else if (data.deliveredState == DeliveredState.loaded)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.blue,
                  child: ListView.builder(
                      itemCount: data.deliveredGetList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidgets(
                                      name: 'ID: ',
                                      id: data.deliveredGetList[index]!.order!
                                          .orderId!
                                          .toString()),
                                  TextWidgets(
                                      name: 'МОДЕЛ: ',
                                      id: data.deliveredGetList[index]!.order!
                                          .model!.name!),
                                  TextWidgets(
                                      name: 'КОЛ-ВО: ',
                                      id: data
                                          .deliveredGetList[index]!.order!.qty
                                          .toString()),
                                  TextWidgets(
                                      name: 'ТКАНЬ: ',
                                      id: data.deliveredGetList[index]!.order!
                                          .tissue!
                                          .toString()),
                                  TextWidgets(
                                      name: 'ЦЕНА: ',
                                      id: data
                                          .deliveredGetList[index]!.order!.cost!
                                          .toString()),
                                  TextWidgets(
                                      name: 'РАСПРОДАЖА: ',
                                      id: '${double.parse(data.deliveredGetList[index]!.order!.sale!).toStringAsFixed(2)} %'),
                                  TextWidgets(
                                      name: 'ЗАГОЛОВОК: ',
                                      id: data
                                          .deliveredGetList[index]!.order!.title
                                          .toString()),
                                  TextWidgets(
                                      name: 'СУММА: ',
                                      id: '${data.deliveredGetList[index]!.order!.sum.toString()} сум'),
                                  ScreenUtil().setVerticalSpacing(10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      color: AppColors.blue,
                                      onPressed: () {
                                        data.putDelivered(data
                                            .deliveredGetList[index]!.orderId!);
                                        data.getDelivered();
                                      },
                                      child: const Text(
                                        'Возврат',
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
