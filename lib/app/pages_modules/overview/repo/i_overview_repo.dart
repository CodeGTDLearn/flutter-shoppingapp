import '../../managed_products/entities/product.dart';

abstract class IOverviewRepo {
//  List<Product> getAll();

  Future<List<Product>> getProducts();

  List<Product> get dataSavingAllProducts;

  List<Product> get dataSavingFavoritesProducts;

//  int getOverviewProductsQtde();
//
//  int getOverviewFavoritesQtde();

//  Future<List<Product>> getOverviewFavoriteProducts();

  Future<bool> toggleFavoriteStatus(String id);

  Product getProductById(String id);
  // Future<Product> getProductById(String id);

  void clearDataSavingLists();
}

