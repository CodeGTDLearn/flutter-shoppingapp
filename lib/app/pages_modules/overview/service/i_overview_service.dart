import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';

abstract class IOverviewService {
  Future<List<Product>> getProducts();

  Future<List<Product>> getProductsByFilter(Popup filter);

  int qtdeFavorites();

  int qtdeProducts();
}
