import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'components/popup_options_appbar.dart';
import 'product.dart';
import 'product_repo.dart';

part 'overview_grid_product_controller.g.dart';

class OverviewGridProductController = OverviewGridProductControllerBase
    with _$OverviewGridProductController;

abstract class OverviewGridProductControllerBase with Store {
  final _repo = Modular.get<ProductsRepo>();

  @observable
  List<Product> filteredProducts = [];

  @observable
  bool hasFavorites;

  @action
  void applyFilter(PopupOptionsAppbar filter) {
    if (filter == PopupOptionsAppbar.Favorites && qtdeFavorites() != 0) {
      filteredProducts = _repo.getFavorites();
      hasFavorites = true;
    } else if (filter == PopupOptionsAppbar.Favorites && qtdeFavorites() == 0) {
      hasFavorites = false;
    } else if (filter == PopupOptionsAppbar.All && qtdeItems() != 0) {
      filteredProducts = _repo.getAll();
    }
  }

  int qtdeFavorites() {
    return _repo.getFavorites().length;
  }

  int qtdeItems() {
    return _repo.getAll().length;
  }
}
