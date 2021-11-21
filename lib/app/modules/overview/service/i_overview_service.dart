import '../../inventory/entity/product.dart';
import '../core/custom_appbar/appbar_filter_options.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  void addProductInLocalDataAllProducts(Product product);

  List<Product> getLocalDataAllProducts();

  List<Product> getLocalDataFavoritesProducts();

  List<Product> setProductsByFilter(AppbarFilterOptions filter);

  Future<bool> toggleFavoriteStatus(String id);

  void updateProductInLocalDataLists(Product product);

  void deleteProductInLocalDataLists(String productId);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void clearDataSavingLists();
}