import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/orders_feature/data/zayavki_getModel.dart';
import 'package:woodline_sklad/features/orders_feature/repository/zayavkiRepository.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum ZayavkiState { neytral, loading, loaded, listbosh }

class ZayavkiProvider extends ChangeNotifier {
  final int _pageSize = 10;
  ZayavkiGetModel? newItems;
  List<Product?> listproduct = [];

  Future<void> fetchPage(int pageKey, final pagingController) async {
    try {
      newItems = (await ZayavkiRepository().getZayavki(pageKey, _pageSize));
      listproduct = newItems!.products!;
      notifyListeners();
      final isLastPage = listproduct.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(listproduct);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(listproduct, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  // ZayavkiState zayavkiState = ZayavkiState.neytral;
  // List<Product?> zayavkiGetList = [];

  // Future<void> getZayavki() async {
  //   zayavkiState = ZayavkiState.loading;
  //   final zayavkirepoSitory = await ZayavkiRepository().getZayavki();
  //   zayavkiGetList = zayavkirepoSitory!.products!;
  //   zayavkiState = ZayavkiState.loaded;
  //   notifyListeners();

  //   if (zayavkiGetList.isEmpty) {
  //     zayavkiState = ZayavkiState.listbosh;
  //     debugPrint(zayavkiGetList.toString());
  //     notifyListeners();
  //   }
  // }
}
