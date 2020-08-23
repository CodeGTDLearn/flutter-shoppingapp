import 'package:get/get.dart';

import '../../../managed_products/entities/product.dart';
import '../../repo/i_overview_repo.dart';

class OverviewItemController extends GetxController {
  final IOverviewRepo _repo = Get.find();

  var favoriteStatus = false.obs;
//TODO: TRABALHANDO NO PROBLEMA DO FAVORITES
  // FAZER O SERVICE DO OVERVIEW
  // FAZER A CONEXAO REPO -> SERVICE -> CONTROLLER
  /*
*The method 'then' was called on null.
Receiver: null
Tried calling: then<Null>(Closure: (bool) => Null)

When the exception was thrown, this was the stack:
#0      Object.noSuchMethod (dart:core-patch/object_patch.dart:51:5)
#1      OverviewItemController.toggleFavoriteStatus (package:shopingapp/app/pages_modules/overview/components/overview_item/overview_item_controller.dart:12:36)
#2      OverviewItem.build.<anonymous closure>.<anonymous closure> (package:shopingapp/app/pages_modules/overview/components/overview_item/overview_item.dart:47:32)
#3      _InkResponseState._handleTap (package:flutter/src/material/ink_well.dart:992:19)
#4      _InkResponseState.build.<anonymous closure> (package:flutter/src/material/ink_well.dart:1098:38)
*
*
* */
  void toggleFavoriteStatus(String id) {
    _repo.toggleFavoriteStatus(id).then((bool) {
      favoriteStatus.value = bool.isNull ? false : bool;
    });
  }

  Product getById(String id) {
    _repo.getById(id).then((product) {
      return product;
    });
  }
}
