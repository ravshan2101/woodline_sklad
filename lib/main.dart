import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/delivery_feature/presentation/provider/delivery_provider.dart';
import 'package:woodline_sklad/features/orders_feature/presentation/provider/zayavki_provider.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/provider/transfer_provider.dart';
import 'package:woodline_sklad/features/warehouse_feature/provider/choose_provider.dart';
import 'package:woodline_sklad/features/warehouse_feature/provider/product_getProvider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedToken = await AuhtLocalData().getToken();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TransferProvider()),
      ChangeNotifierProvider(create: (_) => ZayavkiProvider()),
      ChangeNotifierProvider(create: (_) => DeliveredProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => ChooseProvider())
    ],
    child: MyApp(
      savedToken: savedToken,
    ),
  ));
}
