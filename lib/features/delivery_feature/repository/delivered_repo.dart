import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/delivery_feature/data/delivery_getModel.dart';

class DeliveredRepository {
  Dio? dio;

  DeliveredRepository() {
    final options = BaseOptions(
        sendTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        contentType: 'application/json');

    dio = Dio(options);
  }

  Future<DeliveredModel?> getDelivered() async {
    DeliveredModel? deliveredItems;
    final token = await AuhtLocalData().getToken();

    try {
      Response response = await dio!.get(
          'http://64.226.90.160:3005/warehouse-products-by-status?status=DELIVERED',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': "Bearer $token"
          }));

      if (response.statusCode == 200) {
        deliveredItems = DeliveredModel.fromJson(response.data);

        return deliveredItems;
      }
    } on DioError catch (error) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          msg: error.toString(),
          textColor: AppColors.white,
          fontSize: 16,
          backgroundColor: AppColors.grey);
      debugPrint('---------------------------------------$error-------');
    }

    return deliveredItems;
  }
}
