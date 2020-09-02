import 'package:get/get.dart';

import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo _repo = Get.find();

  List<Product> _dataSavingProducts = [];

  @override
  List<Product> get dataSavingProducts => [..._dataSavingProducts];

  @override
  Future<List<Product>> getProducts() {
    return _repo.getProducts().then((products) {
      clearDataSavingLists();
      _dataSavingProducts = products;
      _orderDataSavingLists();
      return products;
    });
  }

  @override
  int managedProductsQtde() {
    return dataSavingProducts.length;
  }

  @override
  Product getProductById(String id) {
    var _index = _dataSavingProducts.indexWhere((item) => item.id == id);
    return _dataSavingProducts[_index];
  }

  @override
  Future<void> saveProduct(Product product) {
    return _repo.saveProduct(product).then((product) {
      _dataSavingProducts.add(product);
      return product;
    }).catchError((onError) {
      _dataSavingProducts.remove(product);
      throw onError;
    });
  }

  @override
  Future<int> updateProduct(Product product) {
    return _repo.updateProduct(product).then((statusCode) => statusCode);
  }

  @override
  Future<int> deleteProduct(String id) {
    final _index = _dataSavingProducts.indexWhere((item) => item.id == id);
    var _rollbackDataSavingProducts = [..._dataSavingProducts];
    _dataSavingProducts.removeAt(_index);
    _orderDataSavingLists();
    return _repo.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        _dataSavingProducts = _rollbackDataSavingProducts;
        _orderDataSavingLists();
      }
      return statusCode;
    });
  }

  @override
  void clearDataSavingLists() {
    _dataSavingProducts = [];
  }

  void _orderDataSavingLists() {
    _dataSavingProducts.toList().reversed;
  }
}
