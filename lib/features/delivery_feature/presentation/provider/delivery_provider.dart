import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/delivery_feature/data/delivery_getModel.dart';
import 'package:woodline_sklad/features/delivery_feature/repository/delivered_repo.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum DeliveredState { neytral, loading, loaded, listbosh }

class DeliveredProvider extends ChangeNotifier {
  final int _pageSize = 10;
  DeliveredModel? newItems;
  List<Product?> listproduct = [];

  Future<void> fetchPage(int pageKey, final pagingController) async {
    try {
      newItems = (await DeliveredRepository().getDelivered(pageKey, _pageSize));
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
}
