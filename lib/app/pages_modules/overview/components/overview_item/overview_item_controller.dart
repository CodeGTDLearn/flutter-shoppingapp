import 'package:get/get.dart';

import '../../../managed_products/entities/product.dart';
import '../../repo/i_overview_repo.dart';


 class OverviewItemController extends GetxController {
  final IOverviewRepo _repo = Get.find();

  var favoriteStatus = false.obs;

  void toggleFavoriteStatus(String id) {
    favoriteStatus.value = _repo.toggleFavoriteStatus(id);
  }

  Product getById(String id) {
    return _repo.getById(id);
  }
}
