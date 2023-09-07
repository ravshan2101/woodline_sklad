import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_id_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';

import 'package:woodline_sklad/features/warehouse_feature/data/product_order_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_post_action_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_search_action_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_skladItems_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_skladTranfer_md.dart';

class ProduktRepository {
  Dio? dio;
  List<Product?> list = [];

  ProduktRepository() {
    final options = BaseOptions(
        sendTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        contentType: 'application/json');

    dio = Dio(options);
  }

  Future<ProductsModel?> getProduckt(int page, int limit) async {
    ProductsModel? producktItems;

    final token = await AuhtLocalData().getToken();

    try {
      Response response = await dio!.get(
          'http://64.226.90.160:3005/warehouse-products-by-status?status=PRODUCTS&page=$page&limit=$limit',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': "Bearer $token"
          }));

      if (response.statusCode == 200) {
        producktItems = ProductsModel.fromJson(response.data);
        return producktItems;
      }
    } on DioError catch (error) {
      debugPrint(error.toString());
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          msg: error.toString(),
          textColor: AppColors.white,
          fontSize: 16,
          backgroundColor: AppColors.grey);
      debugPrint('---------------------------------------$error-------');
    }

    return producktItems;
  }

  Future<Product?> putProduct(
      {required String id, required String status}) async {
    final token = await AuhtLocalData().getToken();
    Product? productsOrder;
    try {
      Response response =
          await dio!.put('http://64.226.90.160:3005/order/$id?status=$status',
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token"
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        productsOrder = Product.fromJson(response.data);
        debugPrint("${productsOrder.order!.status!}_________sta");
        debugPrint(response.data.toString());
        return productsOrder;
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
      return productsOrder;
    }
    return productsOrder;
  }

  Future<List<ProductSearch?>> getSearch(String text) async {
    final token = await AuhtLocalData().getToken();
    List<ProductSearch?> productSearch = [];
// has-order-id/meId
    try {
      Response response =
          await dio!.get('http://64.226.90.160:3005/search-model/?name=$text',
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token"
              }));
      if (response.statusCode == 200) {
        productSearch = productSearchFromJson(response.data);
        return productSearch;
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
    return productSearch;
  }

  Future<ProductId?> getID(String id) async {
    final token = await AuhtLocalData().getToken();
    ProductId? prductId;
    try {
      Response response =
          await dio!.get("http://64.226.90.160:3005/has-order-id/$id",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token"
              }));

      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        if (response.data == null) {
          prductId = null;
        } else {
          prductId = ProductId.fromJson(response.data);
        }
        return prductId;
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
    return prductId;
  }

  Future<ProductPostModel?> postProduct(
      {required String id,
      required String tissue,
      required String title,
      required String idModel}) async {
    ProductPostModel? productPostModel;
    final token = await AuhtLocalData().getToken();
    final data = {
      "order_id": id,
      "cathegory": "string",
      "tissue": tissue,
      "title": title,
      "cost": 0,
      "sale": 0,
      "qty": 1,
      "sum": 0,
      "model_id": idModel
    };

    try {
      Response response =
          await dio!.post("http://64.226.90.160:3005/warehouse-products",
              data: data,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token"
              }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        productPostModel = ProductPostModel.fromJson(response.data);
        debugPrint(productPostModel.id);
        return productPostModel;
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
    return productPostModel;
  }

  Future<List<TransferSkladItems?>> getSklad() async {
    final token = await AuhtLocalData().getToken();
    List<TransferSkladItems?> items = [];

    try {
      Response response = await dio!.get(
          "http://64.226.90.160:3005/warehouse-all",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      if (response.statusCode == 200) {
        items = transferSkladItemsFromJson(response.data);
        debugPrint(items.last!.name);
        return items;
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
    return items;
  }

  Future<TransferSkladModel?> putSklad(
      {required String orderId, required String whereHouseId}) async {
    final token = await AuhtLocalData().getToken();
    TransferSkladModel? skladModel;
    final data = {'warehouse_id': whereHouseId};
    try {
      Response response = await dio!
          .put('http://64.226.90.160:3005/change-warehouse-products/$orderId',
              data: data,
              options: Options(headers: {
                "Content-Type": "application/json",
                'Accept': 'application/json',
                "Authorization": "Bearer $token"
              }));

      if (response.statusCode == 200) {
        skladModel = TransferSkladModel.fromJson(response.data);
        debugPrint(skladModel.id);
        return skladModel;
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
    return skladModel;
  }

  Future<ProductsModel?> getSearchGl({required String id}) async {
    final token = await AuhtLocalData().getToken();
    ProductsModel? productSearchGl;

    try {
      Response response = await dio!.get(
          // 'http://64.226.90.160:3005/warehouse-products-search?search=$id',
          'http://64.226.90.160:3005/warehouse-products-by-status?status=PRODUCTS&search=$id',
          options: Options(headers: {
            'Content-Type': "application/json",
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        productSearchGl = ProductsModel.fromJson(response.data);

        return productSearchGl;
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
    return productSearchGl;
  }
}
