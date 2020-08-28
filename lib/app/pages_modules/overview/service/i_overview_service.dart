import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

//  Future<List<Product>> getProductsByFilter(Popup filter);
  List<Product> getProductsByFilter(EnumFilter filter);

  Future<bool> toggleFavoriteStatus(String id);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);
  // Future<Product> getProductById(String id);

  void clearDataSavingLists();
}
