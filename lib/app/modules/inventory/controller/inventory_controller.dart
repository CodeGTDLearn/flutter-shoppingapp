import 'package:get/get.dart';

import '../entity/product.dart';
import '../service/i_inventory_service.dart';

class InventoryController extends GetxController {
  final IInventoryService service;

  var inventoryProductsObs = <Product>[].obs;
  var reloadInventoryEditPageObs = false.obs;

  InventoryController({required this.service});

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    // managedProductsObs.value = [];
    inventoryProductsObs.assignAll([]);
    getProducts();
    super.onInit();
  }

  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) {
      response == null
          ? inventoryProductsObs.assignAll([])
          : inventoryProductsObs.assignAll(response);
      return inventoryProductsObs.toList();
    }).catchError((onError) => throw onError);
  }

  int getProductsQtde() {
    return service.getProductsQtde();
  }

  Product getProductById(String id) {
    return service.getProductById(id);
  }

  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return service.addProduct(_product).then((addedProduct) {
      return addedProduct;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    return service.updateProduct(product).then((statusCode) => statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    var responseFuture = service.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());
      }
      return statusCode;
    });

    inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());

    return responseFuture;
    // @formatter:on
  }

  void switchInventoryAddEditFormToCustomCircularProgrIndic() {
    reloadInventoryEditPageObs.value = !reloadInventoryEditPageObs.value;
  }

  void updateInventoryProductsObs() {
    inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());
  }

  List<Product> getInventoryProductsObs() {
    return inventoryProductsObs.toList();
  }

  bool getReloadInventoryProductsEditPageObs() {
    return reloadInventoryEditPageObs.value;
  }
}
