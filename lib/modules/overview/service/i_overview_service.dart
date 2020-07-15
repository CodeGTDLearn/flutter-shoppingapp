import '../components/popup_appbar_enum.dart';
import '../product.dart';

abstract class IOverviewService {
  List<Product> getProductsFiltering(Popup filter);

  int qtdeFavorites();

  int qtdeProducts();
}
