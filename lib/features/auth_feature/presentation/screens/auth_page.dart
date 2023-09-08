import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/provider/auth_provider_service.dart';
import 'package:woodline_sklad/features/auth_feature/validator_auth/validators_auth.dart';

import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authProvider = AuthService();
  final username = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> formKeyUser = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                  height: 400.h,
                  child: Lottie.asset('assets/animation/2.json')),
              Form(
                key: formKeyUser,
                child: TextFieldWidget(
                  valueChanged: (value) {
                    formKeyUser.currentState!.validate();
                  },
                  validator: Validators.userName,
                  textEditingController: username,
                  name: 'Username',
                  cursorHeight: 20.h,
                  vertical: 15,
                ),
              ),
              ScreenUtil().setVerticalSpacing(20),
              Form(
                key: formKeyPassword,
                child: TextFieldWidget(
                  valueChanged: (value) {
                    formKeyPassword.currentState!.validate();
                  },
                  validator: Validators.passwordString,
                  textEditingController: password,
                  name: 'Password',
                  cursorHeight: 20.h,
                  vertical: 15,
                ),
              ),
              ScreenUtil().setVerticalSpacing(50),
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.r)),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  onPressed: () async {
                    final isValidateUser = formKeyUser.currentState!.validate();
                    final isValidatePassword =
                        formKeyPassword.currentState!.validate();

                    if (isValidateUser && isValidatePassword) {
                      if (authProvider.loginState == LoginState.loading) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      }

                      final authModel = await authProvider.login(
                          username.text.trim(), password.text.trim());

                      if (authModel != null) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.home);
                        await AuhtLocalData()
                            .saveToken(authModel.token!.token!);
                      }

                      if (authModel == null) {
                        Fluttertoast.showToast(
                            timeInSecForIosWeb: 2,
                            gravity: ToastGravity.TOP,
                            msg: 'Информация не найдена',
                            textColor: AppColors.white,
                            fontSize: 16,
                            backgroundColor: Colors.red);
                      }
                    }

                    // Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                  },
                  child: const Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuhtLocalData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('token', token);
    debugPrint("save token______________$token");
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenFcm = prefs.getString('token');
    debugPrint('token-----------------------------$tokenFcm------ fromlocal');
    return tokenFcm;
  }

  Future<bool> removeToken() async {
    final SharedPreferences prefs = await _prefs;
    final removeToken = prefs.remove('token');
    debugPrint('-----------------------removeToken----$removeToken');
    return removeToken;
  }
}
