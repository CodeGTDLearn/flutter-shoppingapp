import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';

abstract class IOverviewController {
  void getProductsByFilter(EnumFilter filter);

  Future<bool> toggleFavoriteStatus(String id);

  Product getProductById(String id);

  Future<List<Product>> getProducts();

  int getFavoritesQtde();

  int getProductsQtde();

  bool getFavoriteStatusObs();

  List<Product> getFilteredProductsObs ();
}
