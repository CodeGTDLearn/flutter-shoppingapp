import '../../../core/components/custom_appbar/filter_favorite_enum.dart';
import '../../inventory/entity/product.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  void addProductInLocalDataAllProducts(Product product);

  List<Product> getLocalDataAllProducts();

  List<Product> getLocalDataFavoritesProducts();

  List<Product> setProductsByFilter(EnumFilter filter);

  Future<bool> toggleFavoriteStatus(String id);

  void updateProductInLocalDataLists(Product product);

  void deleteProductInLocalDataLists(String productId);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void clearDataSavingLists();
}