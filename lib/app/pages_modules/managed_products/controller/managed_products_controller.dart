import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService _service = Get.find();

  // GERENCIA DE ESTADO REATIVA - COM O GET
  var managedProductsObs = <Product>[].obs;
  var reloadManagedProductsEditPage = false.obs;

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    managedProductsObs.value = [];
    getAllManagedProducts();
  }

  Future<List<Product>> getAllManagedProducts() {
    return _service.getAllManagedProducts().then((response) {
      managedProductsObs.value = response.isNull ? [] : response;
    }).catchError((onError) => throw onError);
  }

  int managedProductsQtde() {
    return _service.managedProductsQtde();
  }

//  Future<Product> getByIdManagedProduct(String id) {
  Product getByIdManagedProduct(String id) {
    return _service.getByIdManagedProduct(id);
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

  Future<int> deleteManagedProduct(String id) {
    // @formatter:off
    var _index = managedProductsObs.value.indexWhere((item)=> item.id == id);
    var rollbackProduct = managedProductsObs.value[_index];
    managedProductsObs.value.removeAt(_index);
    getAllManagedProducts();

    return _service
        .deleteManagedProduct(id)
        .then((response) {
          if (response >= 400) {
              managedProductsObs.value.add(rollbackProduct);
//            throw HttpException("Something wronged happens");
          }
              rollbackProduct = null;
              getAllManagedProducts();
              return response;
        });
    // @formatter:on
  }

  void toggleReloadManagedProductsEditPage() {
    reloadManagedProductsEditPage.value = !reloadManagedProductsEditPage.value;
  }
}

// GERENCIA DE ESTADO SIMPLES - COM O GET
//  var managedProducts = <Product>[];
//
//  void getAll() {
//    managedProducts = _service.getAll();
//    update();
//  }
