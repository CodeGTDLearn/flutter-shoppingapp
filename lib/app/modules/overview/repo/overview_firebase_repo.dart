import '../../../datasource/products.dart';
import '../product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  List<Product> _productsFromDb = [];

  @override
  List<Product> getAll() {
    if (products.isNotEmpty && products != null && products.length != 0) {
      return [..._productsFromDb = products];
    }
    return [..._productsFromDb];
  }

  @override
  List<Product> getFavorites() {
    return [
      ..._productsFromDb.where((item) => item.get_isFavorite() == true).toList()
    ];
  }

  @override
  void toggleFavoriteStatus(String id) {
    var productFound = getById(id);
    productFound.set_isFavorite(!productFound.get_isFavorite());
  }

  @override
  Product getById(String id) {
    return _productsFromDb
        .firstWhere((productToBeGoten) => productToBeGoten.get_id() == id);
  }

  @override
  bool add(Product product) {
    _productsFromDb.add(product);
    return !_productsFromDb
        .indexWhere((prod) => prod.get_id() == product.get_id())
        .isNegative;
  }

  @override
  bool update(Product product) {
    final _productFindIndex =
        _productsFromDb.indexWhere((prod) => prod.get_id() == product.get_id());
    if (_productFindIndex >= 0) _productsFromDb[_productFindIndex] = product;
    return !_productsFromDb
        .indexWhere((prod) => prod.get_id() == product.get_id())
        .isNegative;
  }

  @override
  void delete(String id) {
    _productsFromDb.removeWhere((element) => element.get_id() == id);
  }
}
