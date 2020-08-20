import '../../managed_products/entities/product.dart';

abstract class IOverviewRepo {
//  List<Product> getAll();

  Future<List<Product>> getProducts();

  int getProductsQtde();

  int getFavoritesQtde();

  Future<List<Product>> getFavorites();

  bool toggleFavoriteStatus(String id);

  Product getById(String id);
}

//  bool add(Product product);
//
//  bool update(Product product);
//
//  void delete(String id);
