import 'package:flutter/cupertino.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum ProductrState { neytral, loading, loaded, listbosh }

class ProductProvider extends ChangeNotifier {
  final int _pageSize = 10;
  ProductsModel? newItems;
  List<Product?> listproduct = [];

  Future<void> fetchPage(int pageKey, final pagingController) async {
    try {
      newItems = await ProduktRepository().getProduckt(pageKey, _pageSize);
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
