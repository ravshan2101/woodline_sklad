import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/transfer_feature/data/transfered_getModel.dart';

class TransferedRepository {
  Dio? _dio;

  TransferedRepository() {
    final option = BaseOptions(
        sendTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        contentType: 'application/json');

    _dio = Dio(option);
  }

  Future<TransferedGetMd?> getTranfery() async {
    TransferedGetMd? transferedGetMd;
    final token = await AuhtLocalData().getToken();

    try {
      Response response = await _dio!.get(
          'http://64.226.90.160:3005/warehouse-products-by-status?status=TRANSFERED',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': "Bearer $token"
          }));

      if (response.statusCode == 200) {
        transferedGetMd = TransferedGetMd.fromJson(response.data);
        debugPrint(transferedGetMd.products!.first.orderId);
        return transferedGetMd;
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
      return transferedGetMd;
    }
    return transferedGetMd;
  }
}
