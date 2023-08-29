import 'package:flutter/cupertino.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';

enum ProductrState { neytral, loading, loaded, listbosh }

class ProductProvider extends ChangeNotifier {
  ProductrState productrState = ProductrState.neytral;

  List<Product?> listproduct = [];

  Future<void> getProduct() async {
    productrState = ProductrState.loading;
    ProductsModel? productsModel = await ProduktRepository().getProduckt();
    listproduct = productsModel!.products!;
    productrState = ProductrState.loaded;
    notifyListeners();

    if (listproduct.isEmpty) {
      productrState = ProductrState.listbosh;
      notifyListeners();
    }
  }

  Future searchProduct({required String id}) async {
    final productSearch = await ProduktRepository().getSearchGl(id: id);
    listproduct = productSearch!.products!;
    notifyListeners();
  }
}
