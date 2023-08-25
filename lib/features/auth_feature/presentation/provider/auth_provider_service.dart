import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/auth_feature/data/auth_model.dart';
import 'package:woodline_sklad/features/auth_feature/repository/auth_repository.dart';

enum LoginState { neytral, loading, loaded }

class AuthService extends ChangeNotifier {
  LoginState loginState = LoginState.neytral;
  final authrepository = AuthRepository();

  Future<AuthModel?> login(String username, String password) async {
    loginState = LoginState.loading;
    final auth =
        await authrepository.login(username: username, password: password);
    loginState = LoginState.loaded;
    notifyListeners();
    return auth;
  }
}
