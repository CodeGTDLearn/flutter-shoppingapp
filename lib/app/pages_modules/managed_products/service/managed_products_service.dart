import '../../overview/service/i_overview_service.dart';
import '../entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo repo;
  final IOverviewService overviewService;

  List<Product> _localDataManagedProducts = [];

  ManagedProductsService({this.repo, this.overviewService});

  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return repo.getProducts().then((products) {
      clearDataSavingLists();
      _localDataManagedProducts = products;
      _orderDataSavingLists();
      // return _localDataManagedProducts;
      return getLocalDataManagedProducts();
    });
    // @formatter:on
  }

  @override
  int managedProductsQtde() {
    return getLocalDataManagedProducts().length;
  }

  @override
  Product getProductById(String id) {
    var _index = _localDataManagedProducts.indexWhere((item) => item.id == id);
    return _localDataManagedProducts[_index];
  }

  @override
  List<Product> getLocalDataManagedProducts() {
    return [..._localDataManagedProducts];
  }

  @override
  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return repo
        .addProduct(_product)
        .then((addedProduct) {
            // _localDataManagedProducts.add(addedProduct);
            addLocalDataManagedProducts(addedProduct);
            overviewService.addProductInLocalDataAllProducts(addedProduct);
            return addedProduct;})
        .catchError((onError) => throw onError);
        // .catchError((onError) {
        //   _localDataManagedProducts.remove(_product);
        //   throw onError;
        // });
    // @formatter:on
  }

  @override
  void addLocalDataManagedProducts(Product product) {
    _localDataManagedProducts.add(product);
  }

  @override
  Future<int> updateProduct(Product product) {
    return repo.updateProduct(product).then((statusCode) => statusCode);
  }

  @override
  Future<int> deleteProduct(String id) {
    final _index =
        _localDataManagedProducts.indexWhere((item) => item.id == id);
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
