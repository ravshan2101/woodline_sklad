import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/orders_feature/data/zayavki_getModel.dart';
import 'package:woodline_sklad/features/orders_feature/repository/zayavkiRepository.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum ZayavkiState { neytral, loading, loaded, listbosh }

class ZayavkiProvider extends ChangeNotifier {
  ZayavkiState zayavkiState = ZayavkiState.neytral;
  List<Product?> zayavkiGetList = [];

  Future<void> getZayavki() async {
    zayavkiState = ZayavkiState.loading;
    final zayavkirepoSitory = await ZayavkiRepository().getZayavki();
    zayavkiGetList = zayavkirepoSitory!.products!;
    zayavkiState = ZayavkiState.loaded;

    if (zayavkiGetList.isEmpty) {
      zayavkiState = ZayavkiState.listbosh;
      debugPrint(zayavkiGetList.toString());
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> putZayavki(String id) async {
    await ProduktRepository().putProduct(id: id, status: 'SOLD_AND_CHECKED');
    notifyListeners();
  }

  Future getSearch(String id) async {
    final trasferySearch = await ZayavkiRepository().getZayavkiSearch(id);
    zayavkiGetList = trasferySearch!.products!;
    notifyListeners();
  }
}
