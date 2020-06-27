import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../cart/repo/i_cart_repo.dart';
import '../product.dart';
import '../repo/i_overview_firebase_repo.dart';

part 'overview_item_controller.g.dart';

class OverviewItemController = _OverviewItemControllerBase
    with _$OverviewItemController;

abstract class _OverviewItemControllerBase with Store {
  final _repo = Modular.get<IOverviewRepo>();
  final _cartRepo = Modular.get<ICartRepo>();

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

  get cartRepo => _cartRepo;
}
