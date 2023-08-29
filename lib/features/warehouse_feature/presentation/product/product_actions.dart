import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woodline_sklad/app_const/app_colors.dart';
import 'package:woodline_sklad/app_const/app_routes.dart';
import 'package:woodline_sklad/features/auth_feature/validator_auth/validators_auth.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_id_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/data/product_search_action_md.dart';
import 'package:woodline_sklad/features/warehouse_feature/repository/produkt_repository.dart';
import 'package:woodline_sklad/src/widgets/text_field_widget.dart';

class ProduktAction extends StatefulWidget {
  const ProduktAction({super.key});

  @override
  State<ProduktAction> createState() => _ProduktActionState();
}

class _ProduktActionState extends State<ProduktAction> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  ProductsModel? productsModelItem;

  getProducts() async {
    productsModelItem = await ProduktRepository().getProduckt();
    setState(() {});
  }

  String? select;
  String? select2;
  List<ProductSearch?> result = [];
  ProductId? resultId;
  bool isValue = false;
  bool isTrue = false;
  String? mebel;
  String? tissue;
  String? title;
  String? idMebel;
  String? id;
  int counter = 0;

  final idController = TextEditingController();
  final tkanController = TextEditingController();
  final zagalovkaController = TextEditingController();
  final productSearchcontroller = TextEditingController();

  final GlobalKey<FormState> formKeyId = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyTkan = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyZagalovka = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          'Добавить продукт',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Введите ID заказа',
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
              ),
              ScreenUtil().setVerticalSpacing(10),
              Form(
                key: formKeyId,
                child: TextFieldWidget(
                  onchaged: (value) async {
                    if (value.length >= 6) {
                      resultId = await ProduktRepository().getID(value);
                      if (resultId == null) {
                        id = value;
                        isValue = true;
                        Fluttertoast.showToast(
                            msg: "Успешно",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        setState(() {});
                      } else if (value == resultId!.orderId) {
                        isValue = false;
                        Fluttertoast.showToast(
                            msg: "Такой ид уже существует ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {});
                        debugPrint("Malumot bor");
                      }
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  valueChanged: (value) {
                    formKeyId.currentState!.validate();
                  },
                  validator: Validators.id,
                  cursorHeight: 20.h,
                  name: 'id',
                  textEditingController: idController,
                  vertical: 8,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, set) {
                        return DraggableScrollableSheet(
                          initialChildSize: 1,
                          maxChildSize: 1,
                          minChildSize: 1,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: TextFieldWidget(
                                    cursorHeight: 20.h,
                                    textEditingController:
                                        productSearchcontroller,
                                    vertical: 10,
                                    name: 'Поиск..',
                                    onchaged: (value) async {
                                      result = await ProduktRepository()
                                          .getSearch(value);
                                      set(() {});
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: result.isEmpty
                                        ? const Center(
                                            child: Text('Нет информации'))
                                        : ListView.builder(
                                            controller: scrollController,
                                            itemCount: result.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  idMebel = result[index]!.id;
                                                  debugPrint(result[index]!.id);
                                                  mebel =
                                                      "${result[index]!.furnitureType!.name} ${result[index]!.name!}";
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      "  ${result[index]!.furnitureType!.name!} ",
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.grey),
                                                    ),
                                                    Text(
                                                      result[index]!.name!,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ))
                              ],
                            );
                          },
                        );
                      });
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(width: 0.3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mebel == null
                        ? const Text(
                            'Search',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(mebel.toString()),
                  ),
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              Text(
                'Введите название ткани',
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              ScreenUtil().setVerticalSpacing(5),
              Form(
                key: formKeyTkan,
                onChanged: () {
                  formKeyTkan.currentState!.validate();
                },
                child: TextFieldWidget(
                  onchaged: (value) {
                    tissue = value;
                  },
                  validator: Validators.passwordString,
                  name: 'ткани',
                  textEditingController: tkanController,
                  vertical: 8,
                ),
              ),
              ScreenUtil().setVerticalSpacing(20),
              Form(
                key: formKeyZagalovka,
                onChanged: () {
                  formKeyZagalovka.currentState!.validate();
                },
                child: TextFieldWidget(
                    onchaged: (value) {
                      title = value;
                    },
                    isBigTextfield: true,
                    cursorHeight: 20,
                    validator: Validators.passwordString,
                    textEditingController: zagalovkaController,
                    name: 'Заголовок',
                    vertical: 20),
              ),
              ScreenUtil().setVerticalSpacing(20),
              SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    height: 50.h,
                    onPressed: () async {
                      formKeyId.currentState!.validate();
                      formKeyTkan.currentState!.validate();
                      formKeyZagalovka.currentState!.validate();

                      if (isValue == true &&
                          formKeyId.currentState!.validate() &&
                          formKeyTkan.currentState!.validate() &&
                          formKeyZagalovka.currentState!.validate() &&
                          mebel != null &&
                          counter == 0) {
                        await ProduktRepository().postProduct(
                            id: id!,
                            idModel: idMebel!,
                            tissue: tissue!,
                            title: title!);
                        if (counter == 0) {
                          Navigator.of(context).pushNamed(AppRoutes.home);
                          counter++;
                        }
                        Fluttertoast.showToast(
                            msg: "Добавлено в базу данных",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        debugPrint("Sucses");
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    color: AppColors.blue,
                    child: const Text(
                      'Создавать',
                      style: TextStyle(color: AppColors.white),
                    ),
                  )),
              ScreenUtil().setVerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
