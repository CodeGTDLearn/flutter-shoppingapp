import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  List<Product> get getLocalDataAllProducts;

  void addProductInLocalDataAllProducts(Product product);

  List<Product> get localDataFavoritesProducts;

  List<Product> getProductsByFilter(EnumFilter filter);

  Future<bool> toggleFavoriteStatus(String id);

  void updateProductInLocalDataLists(Product product);

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void clearDataSavingLists();
}
