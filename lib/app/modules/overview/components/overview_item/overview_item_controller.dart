import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../../product.dart';
import '../../repo/i_overview_repo.dart';


 class OverviewItemController {
  final IOverviewRepo _repo = Get.find();

  @observable
  bool favoriteStatus;

  @action
  void toggleFavorite(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus = _repo.getById(id).isFavorite;
  }

  Product getById(String id) {
    return _repo.getById(id);
  }
}
