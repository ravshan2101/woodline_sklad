import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/delivery_feature/data/delivery_getModel.dart';
import 'package:woodline_sklad/features/delivery_feature/repository/delivered_repo.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum DeliveredState { neytral, loading, loaded, listbosh }

class DeliveredProvider extends ChangeNotifier {
  DeliveredState deliveredState = DeliveredState.neytral;
  List<Product?> deliveredGetList = [];

  Future<void> getDelivered() async {
    deliveredState = DeliveredState.loading;
    final deliveredrepoSitory = await DeliveredRepository().getDelivered();
    deliveredGetList = deliveredrepoSitory!.products!;
    deliveredState = DeliveredState.loaded;

    if (deliveredGetList.isEmpty) {
      deliveredState = DeliveredState.listbosh;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> putDelivered(String id) async {
    await ProduktRepository().putProduct(id: id, status: 'RETURNED');
    notifyListeners();
  }

  // Future getSearch(String id) async {
  //   final trasferySearch = await DeliveredRepository().;
  //   deliveredGetList = trasferySearch!.products!;
  //   notifyListeners();
  // }
}
