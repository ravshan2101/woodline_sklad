import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/orders_feature/data/zayavki_getModel.dart';

class ZayavkiRepository {
  Dio? dio;

  ZayavkiRepository() {
    final option = BaseOptions(
        sendTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        contentType: 'application/json');

    dio = Dio(option);
  }

  Future<ZayavkiGetModel?> getZayavki(int page, int limit) async {
    final token = await AuhtLocalData().getToken();

    ZayavkiGetModel? zayavkiGetModel;

    try {
      Response response = await dio!.get(
          'http://64.226.90.160:3005/warehouse-products-by-status?page=$page&limit=$limit',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        zayavkiGetModel = ZayavkiGetModel.fromJson(response.data);
        return zayavkiGetModel;
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
    return zayavkiGetModel;
  }

  Future<ZayavkiGetModel?> getZayavkiSearch(String id) async {
    final token = await AuhtLocalData().getToken();

    ZayavkiGetModel? zayavkiGetModel;

    try {
      Response response = await dio!.get(
          'http://64.226.90.160:3005/warehouse-products-by-status?search=$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        zayavkiGetModel = ZayavkiGetModel.fromJson(response.data);
        return zayavkiGetModel;
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
    return zayavkiGetModel;
  }
}
