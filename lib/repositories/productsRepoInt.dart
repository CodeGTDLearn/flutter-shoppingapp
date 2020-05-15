import '../entities/product.dart';

abstract class ProductsRepoInt {
  List<Product> getAll();
  List<Product> getFavorites();
  void toggleFavoriteStatus(String id);
  Product getById(String id);
}
