import '../../managed_products/entities/product.dart';

abstract class IOverviewRepo {

  Future<List<Product>> getProducts();

  Future<int> updateProduct(Product product);
  }

//  List<Product> getAll();
//  int getOverviewProductsQtde();
//  int getOverviewFavoritesQtde();
//  Future<List<Product>> getOverviewFavoriteProducts();
//  Future<Product> getProductById(String id);
