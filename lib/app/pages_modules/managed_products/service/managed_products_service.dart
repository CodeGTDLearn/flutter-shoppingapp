import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo repo;
  List<Product> _localDataProducts = [];

  ManagedProductsService({this.repo});

  @override
  List<Product> get dataSavingProducts => [..._localDataProducts];

  @override
  Future<List<Product>> getProducts() {
    return repo.getProducts().then((products) {
      clearDataSavingLists();
      _localDataProducts = products;
      _orderDataSavingLists();
      return _localDataProducts;
    });
  }

  @override
  int managedProductsQtde() {
    return dataSavingProducts.length;
  }

  @override
  Product getProductById(String id) {
    var _index = _localDataProducts.indexWhere((item) => item.id == id);
    return _localDataProducts[_index];
  }

  @override
  Future<void> saveProduct(Product product) {
    return repo.saveProduct(product).then((product) {
      _localDataProducts.add(product);
      return product;
    }).catchError((onError) {
      _localDataProducts.remove(product);
      throw onError;
    });
  }

  @override
  Future<int> updateProduct(Product product) {
    return repo.updateProduct(product).then((statusCode) => statusCode);
  }

  @override
  Future<int> deleteProduct(String id) {
    final _index = _localDataProducts.indexWhere((item) => item.id == id);
    var _rollbackDataSavingProducts = [..._localDataProducts];
    _localDataProducts.removeAt(_index);
    _orderDataSavingLists();
    return repo.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        _localDataProducts = _rollbackDataSavingProducts;
        _orderDataSavingLists();
      }
      return statusCode;
    });
  }

  @override
  void clearDataSavingLists() {
    _localDataProducts = [];
  }

  void _orderDataSavingLists() {
    _localDataProducts.toList().reversed;
  }
}
