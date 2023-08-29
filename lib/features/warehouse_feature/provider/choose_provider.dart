import 'package:flutter/cupertino.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_skladItems_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum ChooseState { neytral, loading, loaded, listbosh }

class ChooseProvider extends ChangeNotifier {
  ChooseState chooseState = ChooseState.neytral;
  List<TransferSkladItems?> sklad = [];

  Future<void> getSklad() async {
    chooseState = ChooseState.loading;
    sklad = await ProduktRepository().getSklad();
    chooseState = ChooseState.loaded;
    notifyListeners();
    
    if (sklad.isEmpty) {
      chooseState = ChooseState.listbosh;
      notifyListeners();
    }
  }
}
