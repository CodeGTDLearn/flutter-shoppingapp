import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';

abstract class IOverviewService {
  List<Product> getProductsFiltering(Popup filter);

  int qtdeFavorites();

  int qtdeProducts();
}
