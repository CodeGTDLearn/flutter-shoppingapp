import 'package:get/get.dart';

import 'components/popup_appbar_enum.dart';
import 'product.dart';
import 'service/i_overview_service.dart';

class OverviewController {
    final IOverviewService _service = Get.find();

  List<Product> filteredProducts = [];

  bool hasFavorites;

  void applyFilter(Popup filter) {
    if (filter == Popup.Fav) {
      filteredProducts = _service.getProductsFiltering(Popup.Fav);
      hasFavorites = filteredProducts.length != 0 ? true : false;
    } else {
      filteredProducts = _service.getProductsFiltering(Popup.All);
    }
  }

  int qtdeFavorites() {
    return _service.qtdeFavorites();
  }

  int qtdeProducts() {
    return _service.qtdeProducts();
  }
}
