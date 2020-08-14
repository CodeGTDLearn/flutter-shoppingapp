import 'package:get/get.dart';

import '../../../managed_products/entities/product.dart';
import '../../repo/i_overview_repo.dart';


 class OverviewItemController extends GetxController {
  final IOverviewRepo _repo = Get.find();

  var favoriteStatus = false.obs;

  void toggleFavorite(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus.value = _repo.getById(id).isFavorite;
  }

  Product getById(String id) {
    return _repo.getById(id);
  }
}
