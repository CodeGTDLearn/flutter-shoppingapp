import '../../../core/components/custom_appbar/filter_favorite_enum.dart';
import '../../inventory/entity/product.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo repo;

  List<Product> _localDataAllProducts = [];
  List<Product> _localDataFavoritesProducts = [];

  OverviewService({required this.repo});

  @override
  List<Product> getLocalDataAllProducts() {
    return [..._localDataAllProducts];
  }

  @override
  List<Product> getLocalDataFavoritesProducts() {
    return [..._localDataFavoritesProducts];
  }

  @override
  void addProductInLocalDataAllProducts(Product product) {
    _localDataAllProducts.add(product);
    _sortDataSavingLists();
  }

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
    var _previousStatus = _toggleProduct.isFavorite;

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
        _toggleProduct.isFavorite = _previousStatus;
      }
      _sortDataSavingLists();
      return _toggleProduct.isFavorite;
    });
    // @formatter:on
  }

  @override
  void updateProductInLocalDataLists(Product product) {
    // Only LocalDataList are being updated because
    // the ManageProductService already updated the product in "the Cloud",
    // therefore this method only needs its LocalDataLists

    // @formatter:off
    final _productIndexInLocalDataAllProducts =
        _localDataAllProducts.indexWhere((item) => item.id == product.id);
    _localDataAllProducts[_productIndexInLocalDataAllProducts] = product;

    final _productIndexInLocalDataFavoritesProducts =
        _localDataFavoritesProducts.indexWhere((item) => item.id == product.id);
    if (_productIndexInLocalDataFavoritesProducts > 0) {
      _localDataFavoritesProducts[_productIndexInLocalDataFavoritesProducts] = product;
    }

    _sortDataSavingLists();
    // @formatter:on
  }

  @override
  void deleteProductInLocalDataLists(String productId) {
    // @formatter:off
    final _productIndexInLocalDataAllProducts =
        _localDataAllProducts.indexWhere((item) => item.id == productId);
    _localDataAllProducts.removeAt(_productIndexInLocalDataAllProducts);

    final _productIndexInLocalDataFavoritesProducts =
        _localDataFavoritesProducts.indexWhere((item) => item.id == productId);
    if (_productIndexInLocalDataFavoritesProducts > 0) {
      _localDataFavoritesProducts.removeAt(_productIndexInLocalDataFavoritesProducts);
    }

    _sortDataSavingLists();
    // @formatter:on
  }

  @override
  List<Product> setProductsByFilter(EnumFilter filter) {
    _updateLocalDataFavoritesProducts();
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : getLocalDataFavoritesProducts();
    }
    return getProductsQtde() == 0 ? [] : getLocalDataAllProducts();
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
    _localDataAllProducts.reversed;
    _localDataFavoritesProducts.reversed;
  }
}