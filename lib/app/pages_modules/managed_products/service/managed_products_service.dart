import 'package:get/get.dart';

import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo _repo = Get.find();

//  var optimisticList = <Product>[];

  @override
  Future<List<Product>> getAllManagedProducts() {
    return _repo.getAllManagedProducts().then((response) => response);
  }

//  @override
//  List<Product> getAllOptimisticList() {
//    return optimisticList;
//  }

  @override
  int managedProductsQtde() {
    return _repo.getManagedProductsQtde();
  }

  @override
  Future<Product> getByIdManagedProduct(String id) {
    return _repo.getManagedProductById(id).then((value) => value);
  }

  @override
  Future<void> saveManagedProduct(Product product) {
    return _repo
        .saveManagedProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  @override
  Future<void> updateManagedProduct(Product product) {
    return _repo
        .updateManagedProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  @override
  Future<int> deleteManagedProduct(String id) {
    return _repo
        .deleteManagedProduct(id)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }
}
