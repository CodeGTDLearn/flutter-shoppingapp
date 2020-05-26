import '../entities/product.dart';

abstract class ProductsRepoInt {
  List<Product> getAll();
  List<Product> getFavorites();
  void toggleFavoriteStatus(String id);
  Product getById(String id);
  bool add(Product product);
  bool update(Product product);
  void delete(String id) {}
}
