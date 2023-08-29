import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/transfer_feature/data/transfered_getModel.dart';
import 'package:woodline_sklad/features/transfer_feature/repository/transfered_repository.dart';

enum TransferState { neytral, loading, loaded, listbosh }

class TransferProvider extends ChangeNotifier {
  TransferState transferState = TransferState.neytral;
  List<Product?> list = [];

  Future getTranfer() async {
    transferState = TransferState.loading;
    TransferedGetMd? transferedRepository =
        await TransferedRepository().getTranfery();
    list = transferedRepository!.products!;
    transferState = TransferState.loaded;
    notifyListeners();

    if (transferedRepository.products!.isEmpty) {
      transferState = TransferState.listbosh;
      debugPrint(transferedRepository.products!.length.toString());
      notifyListeners();
    }
  }

  Future getSearch(String id) async {
    final trasferySearch = await TransferedRepository().getTranferySearch(id);
    list = trasferySearch!.products!;
    notifyListeners();
  }
}
