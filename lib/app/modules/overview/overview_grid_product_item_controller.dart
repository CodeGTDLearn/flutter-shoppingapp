import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'product.dart';
import 'product_repo.dart';

part 'overview_grid_product_item_controller.g.dart';

class OverviewGridProductItemController = OverviewGridProductItemControllerBase
    with _$OverviewGridProductItemController;

abstract class OverviewGridProductItemControllerBase with Store {
  final _repo = Modular.get<ProductsRepo>();

  @observable
  bool favoriteStatus;

  @action
  void toggleFavoriteStatus(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus = _repo.getById(id).get_isFavorite();
  }

  Product getById(String id) {
    return _repo.getById(id);
  }
}
