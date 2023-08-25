import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedToken = await AuhtLocalData().getToken();
  runApp(MyApp(
    savedToken: savedToken,
  ));
}
