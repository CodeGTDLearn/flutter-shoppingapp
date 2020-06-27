import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'components/popup_appbar_enum.dart';
import 'product.dart';
import 'service/i_overview_service.dart';

part 'overview_controller.g.dart';

class OverviewController = _OverviewControllerBase with _$OverviewController;

abstract class _OverviewControllerBase with Store {
  final _service = Modular.get<IOverviewService>();

  @observable
  List<Product> filteredProducts = [];

  @observable
  bool hasFavorites;

  @action
  void applyFilter(PopupEnum filter) {
    if (filter == PopupEnum.Favorites) {
      filteredProducts = _service.getProductsFiltering(PopupEnum.Favorites);
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
