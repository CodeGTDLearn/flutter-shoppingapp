import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService _service = Get.find();

  // GERENCIA DE ESTADO REATIVA - COM O GET
  var managedProductsObs = <Product>[].obs;
  var reloadView = false.obs;

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    getAllManagedProducts();
  }

  Future<List<Product>> getAllManagedProducts() {
    return _service.getAllManagedProducts().then((response) {
      managedProductsObs.value = response;
    }).catchError((onError) => throw onError);
  }

  void getAllManagedProductsOptmistic() {
    managedProductsObs.value = _service.getAllManagedProductsOptmistic();

  }

  int managedProductsQtde() {
    return _service.managedProductsQtde();
  }

  Future<Product> getByIdManagedProduct(String id) {
    return _service.getByIdManagedProduct(id).then((value) => value);
  }

  Future<void> saveManagedProduct(Product product) {
    return _service
        .saveManagedProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
    ;
  }

  Future<void> updateManagedProduct(Product product) {
    return _service
        .updateManagedProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  void deleteManagedProduct(String id) {
    _service.deleteManagedProduct(id);
    getAllManagedProducts();
  }

  void toggleReloadView() {
    reloadView.value = !reloadView.value;
  }
}

// GERENCIA DE ESTADO SIMPLES - COM O GET
//  var managedProducts = <Product>[];
//
//  void getAll() {
//    managedProducts = _service.getAll();
//    update();
//  }
