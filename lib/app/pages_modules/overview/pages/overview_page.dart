import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages_generic_components/drawwer.dart';
import '../components/badge_shop_cart_appbar.dart';
import '../components/filter_favorite_appbar.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';

class OverviewPage extends StatelessWidget {
  final EnumFilter _enumFilter;

  OverviewPage(this._enumFilter);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _enumFilter == EnumFilter.All
                ? OV_TIT_ALL_APPBAR
                : OV_TIT_FAV_APPBAR,
            key: Key(OV05),
          ),
          actions: [FilterFavoriteAppbar(_enumFilter), BadgeShopCartAppbar()],
        ),
        drawer: Drawwer(),
        body: OverviewGrid(_enumFilter, Get.find<OverviewController>()));
  }
}
