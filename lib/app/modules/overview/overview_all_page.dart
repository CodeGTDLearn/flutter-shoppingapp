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

class OverviewAllPage extends StatefulWidget {
  @override
  _OverviewAllPageState createState() => _OverviewAllPageState();
}

class _OverviewAllPageState
    extends ModularState<OverviewAllPage, OverviewGridProductController> {
//  final _store = Modular.get<OverviewGridProductController>();

  @override
  void initState() {
//    _store.applyFilter(PopupOptionsAppbar.All);
    controller.applyFilter(PopupOptionsAppbar.All);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_ITEMSOVERVIEW_ALL);
    return Scaffold(
        appBar: AppBar(
          title: Text(OVERVIEW_APPBAR_ALL_TIT),
          actions: [
            PopupMenuAppbar(allOption: false, favoriteOption: true),
            BadgeShopCartAppbar()
          ],
        ),
        drawer: Drawwer(),
        body: Observer(
//          builder: (BuildContext _) => GridProducts(_store.filteredProducts),
          builder: (BuildContext _) =>
              GridProducts(controller.filteredProducts),
        ));
  }
}
