import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

class ManagedProductsController extends GetxController {
  final IManagedProductsService _service = Get.find();

  // GERENCIA DE ESTADO REATIVA - COM O GET
  var managedProducts = <Product>[].obs;
  var reloadView = false.obs;

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    //<<<<<<<<<<<<<<<<<<problema qui, e assincrono, ate fazer o
    // load da cloud, a tela e printada
    getAllManagedProducts().then((response) {
      print(response);//<<<<<<<<< os produtos estao aki, nao se sabe pq nao
      // renderiza!!!!!!!!!!!!!!!!!
      managedProducts.value = response;
    }).catchError((onError) => throw onError);
  }

  void toggleIsLoading() {
    reloadView.value = !reloadView.value;
  }

  Future<List<Product>> getAllManagedProducts() {
    return _service
        .getAllManagedProducts()
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  int managedProductsQtde() {
    return _service.managedProductsQtde();
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
    getAllManagedProducts();
  }

  Future<void> addProduct(Product product) {
    return _service
        .addProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
    ;
  }

  void updatte(Product product) {
    _service.update(product);
    getAllManagedProducts();
  }
}
