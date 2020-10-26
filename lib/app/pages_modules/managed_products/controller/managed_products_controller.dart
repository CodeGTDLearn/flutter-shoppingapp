import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService service;
  var managedProductsObs = <Product>[].obs;
  var reloadManagedProductsEditPage = false.obs;

  ManagedProductsController({this.service});

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    managedProductsObs.value = [];
    getProducts();
  }

  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) {
      managedProductsObs.value = response.isNull ? [] : response;
    }).catchError((onError) => throw onError);
  }

  int managedProductsQtde() {
    return service.managedProductsQtde();
  }

  Product getProductById(String id) {
    return service.getProductById(id);
  }

  Future<void> saveProduct(Product product) {
    return service
        .saveProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  Future<int> updateProduct(Product product) {
    return service.updateProduct(product).then((statusCode) => statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    var responseFuture = service
        .deleteProduct(id)
        .then((statusCode) {
          if (statusCode >= 400) {
          managedProductsObs.value = service.localDataManagedProducts;
          }
         return statusCode;
        });
    managedProductsObs.value = service.localDataManagedProducts;
    return responseFuture;
    // @formatter:on
  }

  void reloadManagedProductsAddEditPage() {
    reloadManagedProductsEditPage.value = !reloadManagedProductsEditPage.value;
  }

  void reloadManagedProductsObs() {
    managedProductsObs.value = service.localDataManagedProducts;
  }

}

// GERENCIA DE ESTADO SIMPLES - COM O GET
//  var managedProducts = <Product>[];
//
//  void getAll() {
//    managedProducts = _service.getAll();
//    update();
//  }
