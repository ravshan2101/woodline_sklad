import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:woodline_sklad/features/auth_feature/presentation/screens/auth_page.dart';
import 'package:woodline_sklad/features/transfer_feature/presentation/provider/transfer_provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedToken = await AuhtLocalData().getToken();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TransferProvider())],
    child: MyApp(
      savedToken: savedToken,
    ),
  ));
}
