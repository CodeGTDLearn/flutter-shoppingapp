import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService _service = Get.find();

  var filteredProducts = <Product>[].obs;
  bool hasFavorites;

  void filterProducts(Popup filter) {
    if (filter == Popup.Fav) {
      _service
          .getProductsByFilter(Popup.Fav)
          .then((favoritesProductsListResponse) =>
              filteredProducts.value = favoritesProductsListResponse)
          .catchError((onError) => onError);
      hasFavorites = filteredProducts.length != 0 ? true : false;
    } else {
      _service
          .getProductsByFilter(Popup.All)
          .then((allProductsListResponse) => filteredProducts.value = allProductsListResponse)
          .catchError((onError) => onError);
    }
  }

  Future<List<Product>> getProducts() {
    return _service.getProducts();
  }

  int qtdeFavorites() {
    return _service.qtdeFavorites();
  }

  int qtdeProducts() {
    return _service.qtdeProducts();
  }
}
