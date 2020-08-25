import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';

abstract class IOverviewService {
  Future<List<Product>> getOverviewProducts();

//  Future<List<Product>> getProductsByFilter(Popup filter);
  List<Product> getProductsByFilter(Popup filter);

  Future<bool> toggleOverviewProductFavoriteStatus(String id);

  int getOverviewFavoritesQtde();

  int getOverviewProductsQtde();

  Future<Product> getOverviewProductById(String id);
}
