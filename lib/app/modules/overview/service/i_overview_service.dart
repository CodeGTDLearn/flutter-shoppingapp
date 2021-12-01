import '../../inventory/entity/product.dart';
import '../core/overview_appbar/filter_options.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  void addProductInLocalDataAllProducts(Product product);

  List<Product> getLocalDataAllProducts();

  List<Product> getLocalDataFavoritesProducts();

  List<Product> setProductsByFilter(FilterOptions filter);

  Future<bool> toggleFavoriteStatus(String id);

  void updateProductInLocalDataLists(Product product);

  void deleteProductInLocalDataLists(String productId);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void clearDataSavingLists();
}