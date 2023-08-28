import 'package:flutter/material.dart';
import 'package:woodline_sklad/app_const/app_page_animation.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/homePages/home_page.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_actions.dart';
import 'package:woodline_sklad/features/warehouse_feature/presentation/product/product_transfer.dart';
import 'package:woodline_sklad/features/orders_feature/presentation/screens/zayavki.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return PageAnimation.animatedPageRoute(settings, const AuthScreen());
      case AppRoutes.home:
        return PageAnimation.animatedPageRoute(settings, const HomeScreen());
      case AppRoutes.produktTransfer:
        return PageAnimation.animatedPageRoute(
            settings, const ProduktTransfer());
      case AppRoutes.produckrAction:
        return PageAnimation.animatedPageRoute(settings, const ProduktAction());
      case AppRoutes.produckrAction:
        return PageAnimation.animatedPageRoute(settings, const ZayavkiScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Error'),
                  ),
                ));
    }
  }
}
