import 'package:flutter/material.dart';
import 'package:woodline_sklad/features/transfer_feature/data/transfered_getModel.dart';
import 'package:woodline_sklad/features/transfer_feature/repository/transfered_repository.dart';

enum TransferState { neytral, loading, loaded, listbosh }

enum TransferPagination { neytral, loading, loaded, listbosh }

class TransferProvider extends ChangeNotifier {
  final int _pageSize = 10;
  TransferedGetMd? newItems;
  List<Product?> listproduct = [];

  Future<void> fetchPage(int pageKey, final pagingController) async {
    try {
      newItems = await TransferedRepository().getTranfery(pageKey, _pageSize);
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

  // getTranfer() async {
  //   if (isLoading) return;
  //   isLoading = true;
  //   transferState = TransferState.loading;
  //   transferedRepository =
  //       await TransferedRepository().getTranfery(page, limit);

  //   list.addAll(transferedRepository!.products!);

  //   if (transferedRepository!.products!.isEmpty) {
  //     hasMore = false;
  //   }
  //   notifyListeners();
  //   page++;
  //   isLoading = false;
  //   transferState = TransferState.loaded;
  //   notifyListeners();

  //   if (list.isEmpty) {
  //     transferState = TransferState.listbosh;
  //     debugPrint(transferedRepository!.products!.length.toString());
  //     notifyListeners();
  //   }
  // }

  // Future scrollerListen() async {
  //   if (scrollcontrolle.position.maxScrollExtent == scrollcontrolle.offset) {
  //     print('call');
  //     page++;
  //     if (list.length < limit) {
  //       hasMore = false;
  //       notifyListeners();
  //     }
  //     getTranfer();
  //     notifyListeners();
  //   } else {
  //     print('no call');
  //   }
  // }

  // Future onRefresh() async {
  //   isLoading = false;
  //   hasMore = true;
  //   page = 1;
  //   list.clear();
  //   notifyListeners();
  //   getTranfer();
  //   return Future.delayed(const Duration(milliseconds: 300));
  // }
}
