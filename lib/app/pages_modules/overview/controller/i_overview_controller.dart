import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';

abstract class IOverviewController{

  void onInit();

  void getProductsByFilter(EnumFilter filter);

  Future<List<Product>> getProducts();

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void toggleFavoriteStatus(String id);
}