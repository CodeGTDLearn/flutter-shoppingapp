import 'package:shopingapp/db/Products.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';

class ProductsRepo implements IProductsRepo {
  List<Product> _productsFromDb = PRODUCTS_DB;

  @override
  List<Product> getAll() {
    return [...this._productsFromDb];
  }

  @override
  List<Product> getFavorites() {
    return [...this._productsFromDb.where((item) => item.isFavorite == true).toList()];
  }
}
