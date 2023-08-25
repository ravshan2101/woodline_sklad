import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/auth_feature/data/auth_model.dart';

class AuthRepository {
  Dio? _dio;

  AuthRepository() {
    final options = BaseOptions(
        sendTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 10000),
        contentType: 'application/json');

    _dio = Dio(options);
  }

  Future<AuthModel?> login(
      {required String username, required String password}) async {
    final data = {"name": username, "password": password};
    AuthModel? authModel;
    try {
      Response response =
          await _dio!.post('http://64.226.90.160:3005/login', data: data);

      if (response.statusCode == 200) {
        authModel = AuthModel.fromJson(response.data);
        debugPrint(
            "${authModel.token!.token}----------------------------------");
        return authModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return authModel;
  }
}
