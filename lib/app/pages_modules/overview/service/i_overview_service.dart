import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  List<Product> get dataSavingAllProducts;

  List<Product> get dataSavingFavoritesProducts;

  List<Product> getProductsByFilter(EnumFilter filter);

  Future<bool> toggleFavoriteStatus(String id);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void clearDataSavingLists();

  void _orderDataSavingLists();
}
//  Future<List<Product>> getProductsByFilter(Popup filter);
// Future<Product> getProductById(String id);
