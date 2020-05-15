import '../db/products.dart';
import '../entities/product.dart';
import '../repositories/productsRepoInt.dart';

class ProductsRepo implements ProductsRepoInt {
  List<Product> _productsFromDb = [];

  @override
  List<Product> getAll() {
    if (PRODUCTS_DB.isNotEmpty && PRODUCTS_DB != null && PRODUCTS_DB.length != 0)
      return [...this._productsFromDb = PRODUCTS_DB];
    return [..._productsFromDb];
  }

  @override
  List<Product> getFavorites() {
    return [...this._productsFromDb.where((item) => item.get_isFavorite() == true).toList()];
  }

  @override
  void toggleFavoriteStatus(String id) {
    Product productFound = getById(id);
    productFound.set_isFavorite(!productFound.get_isFavorite());
  }

  @override
  Product getById(String id) {
    return this._productsFromDb.firstWhere((productToBeGoten) => productToBeGoten.get_id() == id);
  }
}
