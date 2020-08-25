import '../../managed_products/entities/product.dart';

abstract class IOverviewRepo {
//  List<Product> getAll();

  Future<List<Product>> getOverviewProducts();

  List<Product> get dataSavingListOverviewProducts;

  List<Product> get dataSavingListOverviewFavoritesProducts;

//  int getOverviewProductsQtde();
//
//  int getOverviewFavoritesQtde();

//  Future<List<Product>> getOverviewFavoriteProducts();

  Future<void> toggleOverviewProductFavoriteStatus(String id);

  Future<Product> getOverviewProductById(String id);
}

