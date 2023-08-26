import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/transfer_feature/data/transfered_getModel.dart';
import 'package:woodline_sklad/features/transfer_feature/repository/transfered_repository.dart';

enum TransferState { neytral, loading, loaded }

class TransferProvider extends ChangeNotifier {
  TransferState transferState = TransferState.neytral;
  List<Product?> list = [];

  Future getTranfer() async {
    transferState = TransferState.loading;
    final transferedRepository = await TransferedRepository().getTranfery();
    list = transferedRepository!.products!;
    transferState = TransferState.loaded;
    debugPrint("Isihladi provider___________${list.first!.orderId!}");
    notifyListeners();
  }
}
