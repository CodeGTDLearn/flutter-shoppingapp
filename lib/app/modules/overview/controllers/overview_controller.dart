import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../cart/repo/i_cart_repo.dart';
import '../components/popup_appbar_enum.dart';
import '../product.dart';
import '../repo/i_overview_firebase_repo.dart';

part 'overview_controller.g.dart';

class OverviewController = _OverviewControllerBase with _$OverviewController;

abstract class _OverviewControllerBase with Store {
  final _overviewRepo = Modular.get<IOverviewRepo>();
  final _cartRepo = Modular.get<ICartRepo>();

  @observable
  List<Product> filteredProducts = [];

  @observable
  bool hasFavorites;

  @action
  void applyFilter(PopupAppbarEnum filter) {
    if (filter == PopupAppbarEnum.Favorites && qtdeFavorites() != 0) {
      filteredProducts = _overviewRepo.getFavorites();
      hasFavorites = true;
    } else if (filter == PopupAppbarEnum.Favorites && qtdeFavorites() == 0) {
      hasFavorites = false;
    } else if (filter == PopupAppbarEnum.All && qtdeProducts() != 0) {
      filteredProducts = _overviewRepo.getAll();
    }
  }

  int qtdeFavorites() {
    return _overviewRepo.getFavorites().length;
  }

  int qtdeProducts() {
    return _overviewRepo.getAll().length;
  }

  int qtdeCartItems() {
    return _cartRepo.getAll().length;
  }
}
