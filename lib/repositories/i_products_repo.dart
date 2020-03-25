import 'package:shopingapp/db/Products.dart';
import 'package:shopingapp/entities_models/product.dart';

abstract class IProductsRepo {
  List<Product> getAll();
  List<Product> getFavorites();
}
