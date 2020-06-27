import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';

import '../../product.dart';
import '../../repo/i_overview_repo.dart';

part 'overview_item_service.g.dart';

class OverviewItemService = _OverviewItemServiceBase with _$OverviewItemService;

abstract class _OverviewItemServiceBase with Store {
  final _repo = Modular.get<IOverviewRepo>();
  final _cartService = Modular.get<ICartService>();

  @observable
  bool favoriteStatus;

  @action
  void toggleFavorite(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus = _repo.getById(id).get_isFavorite();
  }

  Product getById(String id) {
    return _repo.getById(id);
  }

  void addCartItem(Product product) {
    _cartService.addCartItem(product);
  }

  void addCartItemUndo(Product product) {
    _cartService.addCartItemUndo(product);
  }
}
