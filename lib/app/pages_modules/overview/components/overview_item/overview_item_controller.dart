import 'package:get/get.dart';

import '../../../managed_products/entities/product.dart';
import '../../service/i_overview_service.dart';

class OverviewItemController extends GetxController {
  final IOverviewService _service = Get.find();

// todo: Existem dois controller para Overview
//  o OverviewController titular
//  e OvervireItemController
//  Check the possibility of merging fo those controller
  /*
  * Persistent Erro
  * ══╡ EXCEPTION CAUGHT BY GESTURE ╞═══════════════════════════════════════════════════════════════════
The following NoSuchMethodError was thrown while handling a gesture:
The method 'then' was called on null.
Receiver: null
Tried calling: then<void>(Closure: (void) => void)

When the exception was thrown, this was the stack:
#0      Object.noSuchMethod (dart:core-patch/object_patch.dart:51:5)
#1      OverviewService.toggleOverviewProductFavoriteStatus (package:shopingapp/app/pages_modules/overview/service/overview_service.dart:20:51)
#2      OverviewItemController.toggleOverviewProductFavoriteStatus (package:shopingapp/app/pages_modules/overview/components/overview_item/overview_item_controller.dart:12:14)
#3      OverviewItem.build.<anonymous closure>.<anonymous closure> (package:shopingapp/app/pages_modules/overview/components/overview_item/overview_item.dart:47:32)
  *
  * */

  var favoriteStatus = false.obs;

  void toggleOverviewProductFavoriteStatus(String id) {
    _service.toggleOverviewProductFavoriteStatus(id).then((bool) {
      favoriteStatus.value = bool.isNull ? false : bool;
    });
  }

  Product getOverviewProductById(String id) {
    _service.getOverviewProductById(id).then((product) => product);
  }
}
