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
    getProducts();
  }

  Future<List<Product>> getProducts() {
    return _service.getProducts().then((response) {
      managedProductsObs.value = response.isNull ? [] : response;
    }).catchError((onError) => throw onError);
  }

  int managedProductsQtde() {
    return _service.managedProductsQtde();
  }

  Product getProductById(String id) {
    return _service.getProductById(id);
  }

  Future<void> saveProduct(Product product) {
    return _service
        .saveProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
    ;
  }

  Future<void> updateProduct(Product product) {
    return _service
        .updateProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    var _index = managedProductsObs.value.indexWhere((item)=> item.id == id);
    var rollbackProduct = managedProductsObs.value[_index];
    managedProductsObs.value.removeAt(_index);
    getProducts();

    return _service
        .deleteProduct(id)
        .then((response) {
          if (response >= 400) {
              managedProductsObs.value.add(rollbackProduct);
//            throw HttpException("Something wronged happens");
          }
              rollbackProduct = null;
              getProducts();
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
