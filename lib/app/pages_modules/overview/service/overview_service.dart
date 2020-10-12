import '../../managed_products/entities/product.dart';
import '../../managed_products/service/i_managed_products_service.dart';
import '../components/filter_favorite_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  // final IOverviewRepo _repo = Get.find();
  final IOverviewRepo repo;
  final IManagedProductsService managedProductsService;
  List<Product> _localDataAllProducts = [];
  List<Product> _localDataFavoritesProducts = [];

  OverviewService({this.managedProductsService, this.repo});

  @override
  List<Product> get dataSavingAllProducts => [..._localDataAllProducts];

  @override
  List<Product> get dataSavingFavoritesProducts =>
      [..._localDataFavoritesProducts];

  @override
  Future<List<Product>> getProducts() {
    return repo.getProducts().then((products) {
      clearDataSavingLists();
      _localDataAllProducts = products;
      products.forEach((item) {
        if (item.isFavorite) {
          _localDataFavoritesProducts.add(item);
        }
      });
      _sortDataSavingLists();
      return products;
    });
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    final _index = _localDataAllProducts.indexWhere((item) => item.id == id);
    var _toggleProduct = _localDataAllProducts[_index];
    var _rollbackProduct = Product.deepCopy(_toggleProduct);

    _toggleProduct.isFavorite = !_toggleProduct.isFavorite;
    _toggleProduct.isFavorite
        ? _localDataFavoritesProducts.add(_toggleProduct)
        : _localDataFavoritesProducts.remove(_toggleProduct);

    return repo
        .updateProduct(_toggleProduct)
        .then((statusCode) {
            var badRequest = statusCode >= 400;
            if (badRequest) {
              _toggleProduct.isFavorite = _rollbackProduct.isFavorite;
              _localDataAllProducts[_index] = _rollbackProduct;
            }
            if (badRequest && _toggleProduct.isFavorite){
              _localDataFavoritesProducts.remove(_toggleProduct);
            }
            if (badRequest && !_toggleProduct.isFavorite){
              _localDataFavoritesProducts.add(_rollbackProduct);
            }
            _sortDataSavingLists();
            return _toggleProduct.isFavorite;
        });
    // @formatter:on
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    _localDataAllProducts = managedProductsService.dataSavingProducts;
    _reloadDataSavingFavoritesProducts();
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : dataSavingFavoritesProducts;
    }
    return getProductsQtde() == 0 ? [] : dataSavingAllProducts;
  }

  @override
  int getFavoritesQtde() {
    return _localDataFavoritesProducts.length;
  }

  @override
  int getProductsQtde() {
    return _localDataAllProducts.length;
  }

  @override
  Product getProductById(String id) {
    var _index = _localDataAllProducts.indexWhere((item) => item.id == id);
    return _localDataAllProducts[_index];
  }

  @override
  void clearDataSavingLists() {
    _localDataFavoritesProducts = [];
    _localDataAllProducts = [];
  }

  List<Product> _reloadDataSavingFavoritesProducts() {
    _localDataFavoritesProducts = [];
    _localDataAllProducts.forEach((item) {
      if (item.isFavorite) {
        _localDataFavoritesProducts.add(item);
      }
    });
    _sortDataSavingLists();
    return _localDataFavoritesProducts;
  }

  void _sortDataSavingLists() {
    _localDataAllProducts.toList().sort;
    _localDataFavoritesProducts.toList().sort;
  }
}
