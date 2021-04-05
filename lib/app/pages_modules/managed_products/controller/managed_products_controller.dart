import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
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

  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) {
      // return managedProductsObs.value = response.isNull ? [] : response;
      response.isNull
          ? managedProductsObs.assignAll([])
          : managedProductsObs.assignAll(response);
      return managedProductsObs.toList();
    }).catchError((onError) => throw onError);
  }

  int managedProductsQtde() {
    return service.managedProductsQtde();
  }

  Product getProductById(String id) {
    return service.getProductById(id);
  }

  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return service
        .addProduct(_product)
        .then((addedProduct){
            return addedProduct;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    return service.updateProduct(product).then((statusCode) => statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    var responseFuture =
    service
        .deleteProduct(id)
        .then((statusCode) {
            if (statusCode >= 400) {
              managedProductsObs.assignAll(service.getLocalDataManagedProducts());
            }
            return statusCode;
        });

    managedProductsObs.assignAll(service.getLocalDataManagedProducts());

    return responseFuture;
    // @formatter:on
  }

  void switchManagedProdAddEditFormToCustomCircularProgrIndic() {
    reloadManagedProductsEditPageObs.value =
        !reloadManagedProductsEditPageObs.value;
  }

  void updateManagedProductsObs() {
    managedProductsObs.assignAll(service.getLocalDataManagedProducts());
  }

  List<Product> getManagedProductsObs() {
    return managedProductsObs.toList();
  }

  bool getReloadManagedProductsEditPageObs() {
    return reloadManagedProductsEditPageObs.value;
  }
}
