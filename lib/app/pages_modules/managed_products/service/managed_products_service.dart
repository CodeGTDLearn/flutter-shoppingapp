import 'package:get/get.dart';

import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo _repo = Get.find();

//  final ManagedProductsController _controller = Get.find();

  @override
  Future<List<Product>> getAllManagedProducts() {
    return _repo.getAllManagedProducts().then((response) => response);
  }

  @override
  int managedProductsQtde() {
    return _repo.getManagedProductsQtde();
  }

  @override
  Product getById(String id) {
    return _repo.getById(id);
  }

  @override
  Future<void> addProduct(Product product) {
    return _repo
        .addProduct(product)
        .then((response) => response)
        .catchError((onError) => throw onError);
  }

  @override
  void update(Product product) {
    _repo.update(product);
  }

  @override
  void delete(String id) {
    _repo.delete(id);
  }
}
