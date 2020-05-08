import 'package:shopingapp/db/Products.dart';
import 'package:shopingapp/entities_models/Product.dart';
import 'package:shopingapp/repositories/ProductsRepoInt.dart';

class ProductsRepo implements ProductsRepoInt {

  List<Product> _productsFromDb = PRODUCTS_DB;

  @override
  List<Product> getAll() {
    return [...this._productsFromDb];
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
  Product getById(String id){
    return this._productsFromDb.firstWhere((productToBeGoten) => productToBeGoten.get_id() == id);
  }
}
