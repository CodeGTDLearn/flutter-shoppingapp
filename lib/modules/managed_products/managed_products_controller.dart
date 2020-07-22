import 'package:get/get.dart';

import '../core/entities/product.dart';
import 'services/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService _service = Get.find();

  // GERENCIA DE ESTADO REATIVA - COM O GET
  var managedProducts = <Product>[].obs;

  var isLoading = false.obs;

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    getAll();
  }

  void toggleIsLoading(){
    isLoading.value = !isLoading.value;
  }

  void getAll() {
    managedProducts.value = _service.getAll();
  }

  Product getById(String id) {
    return _service.getById(id);
  }

// GERENCIA DE ESTADO SIMPLES - COM O GET
//  var managedProducts = <Product>[];
//
//  void getAll() {
//    managedProducts = _service.getAll();
//    update();
//  }

  void delete(String id) {
    _service.delete(id);
    getAll();
  }

  Future<void> add(Product product) {
    _service.addProduct(product);
  }

  void updatte(Product product) {
    _service.update(product);
    getAll();
  }
}
