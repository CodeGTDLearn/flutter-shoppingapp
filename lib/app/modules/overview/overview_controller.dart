import 'package:get/get.dart';

import 'components/popup_appbar_enum.dart';
import 'product.dart';
import 'service/i_overview_service.dart';
import 'service/overview_service.dart';

class OverviewController {
  final IOverviewService _service = Get.put(OverviewService());

  //@observable
  List<Product> filteredProducts = [];

  //@observable
  bool hasFavorites;

  //@action
  void applyFilter(PopupEnum filter) {
    if (filter == PopupEnum.Fav) {
      filteredProducts = _service.getProductsFiltering(PopupEnum.Fav);
      hasFavorites = filteredProducts.length != 0 ? true : false;
    } else {
      filteredProducts = _service.getProductsFiltering(PopupEnum.All);
    }
  }

  int qtdeFavorites() {
    return _service.qtdeFavorites();
  }

  int qtdeProducts() {
    return _service.qtdeProducts();
  }
}
