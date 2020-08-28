import 'package:get/get.dart';

import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo _repo = Get.find();

//  var optimisticList = <Product>[];

  @override
  Future<List<Product>> getProducts() {
    return _repo.getProducts().then((response) => response);
  }

  @override
  int managedProductsQtde() {
    return _repo.dataSavingProducts.isNull ? 0 : _repo.dataSavingProducts.length;
  }

  @override
//  Future<Product> getByIdManagedProduct(String id) {
  Product getProductById(String id) {
    return _repo.getProductById(id);
  }

  @override
  Future<void> saveProduct(Product product) {
    return _repo
        .saveProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  @override
  Future<void> updateProduct(Product product) {
    return _repo
        .updateProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  @override
  Future<int> deleteProduct(String id) {
    return _repo
        .deleteProduct(id)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }
}
