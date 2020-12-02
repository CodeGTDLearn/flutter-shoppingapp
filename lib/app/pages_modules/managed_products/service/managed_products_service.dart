import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo repo;
  List<Product> _localDataManagedProducts = [];

  ManagedProductsService({this.repo});

  @override
  List<Product> get localDataManagedProducts => [..._localDataManagedProducts];

  @override
  Future<List<Product>> getProducts() {
    return repo.getProducts().then((products) {
      clearDataSavingLists();
      _localDataManagedProducts = products;
      _orderDataSavingLists();
      return _localDataManagedProducts;
    });
  }

  @override
  int managedProductsQtde() {
    return localDataManagedProducts.length;
  }

  @override
  Product getProductById(String id) {
    var _index = _localDataManagedProducts.indexWhere((item) => item.id == id);
    return _localDataManagedProducts[_index];
  }

  @override
  Future<void> addProduct(Product product) {
    return repo.addProduct(product).then((product) {
      _localDataManagedProducts.add(product);
      return product;
    }).catchError((onError) {
      _localDataManagedProducts.remove(product);
      throw onError;
    });
  }

  @override
  Future<int> updateProduct(Product product) {
    return repo.updateProduct(product).then((statusCode) => statusCode);
  }

  @override
  Future<int> deleteProduct(String id) {
    final _index = _localDataManagedProducts.indexWhere((item) => item.id == id);
    var _rollbackDataSavingProducts = [..._localDataManagedProducts];
    _localDataManagedProducts.removeAt(_index);
    _orderDataSavingLists();
    return repo.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        _localDataManagedProducts = _rollbackDataSavingProducts;
        _orderDataSavingLists();
      }
      return statusCode;
    });
  }

  @override
  void clearDataSavingLists() {
    _localDataManagedProducts = [];
  }

  void _orderDataSavingLists() {
    _localDataManagedProducts.toList().reversed;
  }
}
