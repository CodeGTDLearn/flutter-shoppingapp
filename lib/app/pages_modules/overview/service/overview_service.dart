import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo repo;

  List<Product> _localDataAllProducts = [];
  List<Product> _localDataFavoritesProducts = [];

  OverviewService({this.repo});

  @override
  List<Product> get localDataAllProducts => [..._localDataAllProducts];

  @override
  List<Product> get localDataFavoritesProducts =>
      [..._localDataFavoritesProducts];

  @override
  Future<List<Product>> getProducts() {
    return repo.getProducts().then((products) {
      clearDataSavingLists();
      _localDataAllProducts = products;
      for (var item in products) {
        if (item.isFavorite) {
          _localDataFavoritesProducts.add(item);
        }
      }
      // products.forEach((item) {
      //   if (item.isFavorite) {
      //     _localDataFavoritesProducts.add(item);
      //   }
      // });
      _sortDataSavingLists();
      return products;
    });
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    final _index = _localDataAllProducts.indexWhere((item) => item.id == id);
    var _toggleProduct = _localDataAllProducts[_index];
    var _previousFavoriteStatus = _toggleProduct.isFavorite;

    _toggleProduct.isFavorite = !_toggleProduct.isFavorite;

    _toggleProduct.isFavorite
        ? _localDataFavoritesProducts.add(_toggleProduct)
        : _localDataFavoritesProducts.remove(_toggleProduct);

    return repo
        .updateProduct(_toggleProduct)
        .then((statusCode) {
            var badRequest = statusCode >= 400;
            if (badRequest && _toggleProduct.isFavorite){
              _localDataFavoritesProducts.remove(_toggleProduct);
            }
            if (badRequest && !_toggleProduct.isFavorite){
              _localDataFavoritesProducts.add(_toggleProduct);
            }
            if (badRequest) {
              _toggleProduct.isFavorite = _previousFavoriteStatus;
            }
            _sortDataSavingLists();
            return _toggleProduct.isFavorite;
        });
    // @formatter:on
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    _reloadLocalDataFavoritesProducts();
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : localDataFavoritesProducts;
    }
    return getProductsQtde() == 0 ? [] : localDataAllProducts;
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

  List<Product> _reloadLocalDataFavoritesProducts() {
    _localDataFavoritesProducts = [];

    for (var item in _localDataAllProducts) {
      if (item.isFavorite) {
        _localDataFavoritesProducts.add(item);
      }
    }
    // _localDataAllProducts.forEach((item) {
    //   if (item.isFavorite) {
    //     _localDataFavoritesProducts.add(item);
    //   }
    // });
    _sortDataSavingLists();
    return _localDataFavoritesProducts;
  }

  void _sortDataSavingLists() {
    _localDataAllProducts.toList().sort;
    _localDataFavoritesProducts.toList().sort;
  }
}
