import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';

import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  // final IOverviewRepo _repo = Get.find();
  final IOverviewRepo overviewRepo;
  final IManagedProductsService managedProductsService;
  List<Product> _dataSavingAllProducts = [];
  List<Product> _dataSavingFavoritesProducts = [];

  OverviewService({this.managedProductsService, this.overviewRepo});

  @override
  List<Product> get dataSavingAllProducts => [..._dataSavingAllProducts];

  @override
  List<Product> get dataSavingFavoritesProducts =>
      [..._dataSavingFavoritesProducts];

  @override
  Future<List<Product>> getProducts() {
    return overviewRepo.getProducts().then((products) {
      clearDataSavingLists();
      _dataSavingAllProducts = products;
      products.forEach((item) {
        if (item.isFavorite) {
          _dataSavingFavoritesProducts.add(item);
        }
      });
      _sortDataSavingLists();
      return products;
    });
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    final _index = _dataSavingAllProducts.indexWhere((item) => item.id == id);
    var _toggleProduct = _dataSavingAllProducts[_index];
    var _rollbackProduct = Product.deepCopy(_toggleProduct);

    _toggleProduct.isFavorite = !_toggleProduct.isFavorite;
    _toggleProduct.isFavorite
        ? _dataSavingFavoritesProducts.add(_toggleProduct)
        : _dataSavingFavoritesProducts.remove(_toggleProduct);

    return overviewRepo
        .updateProduct(_toggleProduct)
        .then((statusCode) {
            var badRequest = statusCode >= 400;
            if (badRequest) {
              _toggleProduct.isFavorite = _rollbackProduct.isFavorite;
              _dataSavingAllProducts[_index] = _rollbackProduct;
            }
            if (badRequest && _toggleProduct.isFavorite){
              _dataSavingFavoritesProducts.remove(_toggleProduct);
            }
            if (badRequest && !_toggleProduct.isFavorite){
              _dataSavingFavoritesProducts.add(_rollbackProduct);
            }
            _sortDataSavingLists();
            return _toggleProduct.isFavorite;
        });
    // @formatter:on
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    _dataSavingAllProducts = managedProductsService.dataSavingProducts;
    _reloadDataSavingFavoritesProducts();
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : dataSavingFavoritesProducts;
    }
    return getProductsQtde() == 0 ? [] : dataSavingAllProducts;
  }

  @override
  int getFavoritesQtde() {
    return _dataSavingFavoritesProducts.length;
  }

  @override
  int getProductsQtde() {
    return _dataSavingAllProducts.length;
  }

  @override
  Product getProductById(String id) {
    var _index = _dataSavingAllProducts.indexWhere((item) => item.id == id);
    return _dataSavingAllProducts[_index];
  }

  @override
  void clearDataSavingLists() {
    _dataSavingFavoritesProducts = [];
    _dataSavingAllProducts = [];
  }

  List<Product> _reloadDataSavingFavoritesProducts() {
    _dataSavingFavoritesProducts = [];
    _dataSavingAllProducts.forEach((item) {
      if (item.isFavorite) {
        _dataSavingFavoritesProducts.add(item);
      }
    });
    _sortDataSavingLists();
    return _dataSavingFavoritesProducts;
  }

  void _sortDataSavingLists() {
    _dataSavingAllProducts.toList().sort;
    _dataSavingFavoritesProducts.toList().sort;
  }
}
