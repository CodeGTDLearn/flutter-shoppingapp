import 'package:get/get.dart';

import '../overview/product.dart';
import 'services/i_managed_products_service.dart';
import 'services/managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService _service = Get.put(ManagedProductsService());

  static ManagedProductsController get to => Get.find();

  // GERENCIA DE ESTADO REATIVA - COM O GET
  var managedProducts = <Product>[].obs;

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    getAll();
  }

  void getAll() {
    managedProducts.value = _service.getAll();
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

  void add(Product product) {
    product.id = (DateTime.now().toString());

    _service.add(product);
    getAll();
  }

  Product getById(String id) {
    return _service.getById(id);
  }

  void updatte(Product product) {
    _service.update(product);
    getAll();
  }
}
