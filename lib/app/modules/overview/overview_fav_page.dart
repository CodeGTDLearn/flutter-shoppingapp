import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';
import 'package:shopingapp/app/config/titles_icons/views/overview.dart';
import 'package:shopingapp/app/modules/core/components/drawwer.dart';

import 'components/badge_shop_cart_appbar.dart';
import 'components/grid_products.dart';
import 'components/popup_menu_appbar.dart';
import 'components/popup_options_appbar.dart';
import 'overview_grid_product_controller.dart';

class OverviewFavPage extends StatefulWidget {
  @override
  ItemsOverviewViewState createState() => ItemsOverviewViewState();
}

class ItemsOverviewViewState
    extends ModularState<OverviewFavPage, OverviewGridProductController> {
//  final _store = Modular.get<OverviewGridProductController>();

  @override
  void initState() {
//    _store.applyFilter(PopupOptionsAppbar.Favorites);
    controller.applyFilter(PopupOptionsAppbar.Favorites);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_ITEMSOVERVIEW_FAV);
    return Scaffold(
        appBar: AppBar(title: Text(OVERVIEW_APPBAR_FAV_TIT), actions: [
          PopupMenuAppbar(allOption: true, favoriteOption: false),
          BadgeShopCartAppbar()
        ]),
        drawer: Drawwer(),
        body: Observer(
//          builder: (BuildContext _) => GridProducts(_store.filteredProducts),
          builder: (BuildContext _) =>
              GridProducts(controller.filteredProducts),
        ));
  }
}
