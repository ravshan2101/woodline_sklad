import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodline_sklad/app_const/app_pages.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';

class MyApp extends StatelessWidget {
  final String? savedToken;
  const MyApp({super.key, required this.savedToken});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: savedToken == null ? AppRoutes.auth : AppRoutes.home,
          onGenerateRoute: AppPages.generateRoute,
        );
      },
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
    );
  }
}
