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
  List<Product> get getLocalDataAllProducts => [..._localDataAllProducts];

  @override
  void addProductInLocalDataAllProducts(Product product) {
    _localDataAllProducts.add(product);
  }

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

    return repo.updateProduct(_toggleProduct).then((statusCode) {
      var badRequest = statusCode >= 400;
      if (badRequest && _toggleProduct.isFavorite) {
        _localDataFavoritesProducts.remove(_toggleProduct);
      }
      if (badRequest && !_toggleProduct.isFavorite) {
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
  void updateProductInLocalDataLists(Product product) {
    // @formatter:off
    final _indexLocalDataAllProducts =
    _localDataAllProducts.indexWhere((item) => item.id == product.id);
    _localDataAllProducts[_indexLocalDataAllProducts] = product;

    final _indexLocalDataFavoritesProducts =
      _localDataFavoritesProducts.indexWhere((item) => item.id == product.id);
    if(_indexLocalDataFavoritesProducts > 0){
      _localDataFavoritesProducts[_indexLocalDataFavoritesProducts] = product;}
    // @formatter:on
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    _updateLocalDataFavoritesProducts();
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : localDataFavoritesProducts;
    }
    return getProductsQtde() == 0 ? [] : getLocalDataAllProducts;
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

  List<Product> _updateLocalDataFavoritesProducts() {
    _localDataFavoritesProducts = [];

    for (var item in _localDataAllProducts) {
      if (item.isFavorite) {
        _localDataFavoritesProducts.add(item);
      }
    }
    _sortDataSavingLists();
    return _localDataFavoritesProducts;
  }

  void _sortDataSavingLists() {
    _localDataAllProducts.toList().sort;
    _localDataFavoritesProducts.toList().sort;
  }
}
