import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';
import 'i_managed_products_controller.dart';

class ManagedProductsController extends GetxController
    implements IManagedProductsController {
  final IManagedProductsService service;

  var managedProductsObs = <Product>[].obs;
  var reloadManagedProductsEditPageObs = false.obs;

  ManagedProductsController({this.service});

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    // managedProductsObs.value = [];
    managedProductsObs.assignAll([]);
    getProducts();
    super.onInit();
  }

  @override
  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) {
      // return managedProductsObs.value = response.isNull ? [] : response;
      response.isNull
          ? managedProductsObs.assignAll([])
          : managedProductsObs.assignAll(response);
      return managedProductsObs.toList();
    }).catchError((onError) => throw onError);
  }

  @override
  int managedProductsQtde() {
    return service.managedProductsQtde();
  }

  @override
  Product getProductById(String id) {
    return service.getProductById(id);
  }

  @override
  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return service
        .addProduct(_product)
        .then((addedProduct) => addedProduct)
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<int> updateProduct(Product product) {
    return service.updateProduct(product).then((statusCode) => statusCode);
  }

  @override
  Future<int> deleteProduct(String id) {
    // @formatter:off
    var responseFuture = service.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        managedProductsObs.assignAll(service.getLocalDataManagedProducts());
      }
      return statusCode;
    });
    managedProductsObs.assignAll(service.getLocalDataManagedProducts());
    return responseFuture;
    // @formatter:on
  }

  @override
  void switchManagedProdAddEditFormToCustomCircularProgrIndic() {
    reloadManagedProductsEditPageObs.value =
        !reloadManagedProductsEditPageObs.value;
  }

  @override
  void updateManagedProductsObs() {
    managedProductsObs.assignAll(service.getLocalDataManagedProducts());
  }

  @override
  List<Product> getManagedProductsObs() {
    return managedProductsObs.toList();
  }

  @override
  bool getReloadManagedProductsEditPageObs() {
    return reloadManagedProductsEditPageObs.value;
  }
}
