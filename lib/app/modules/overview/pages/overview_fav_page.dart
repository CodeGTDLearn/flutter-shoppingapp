import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../../core/components/drawwer.dart';
import '../components/badge_shop_cart_appbar.dart';
import '../components/overview_items_grid.dart';
import '../components/popup_appbar.dart';
import '../components/popup_appbar_enum.dart';
import '../controllers/overview_controller.dart';

class OverviewFavPage extends StatefulWidget {
  @override
  ItemsOverviewViewState createState() => ItemsOverviewViewState();
}

class ItemsOverviewViewState
    extends ModularState<OverviewFavPage, OverviewController> {
  @override
  void initState() {
    controller.applyFilter(PopupAppbarEnum.Favorites);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_ITEMSOVERVIEW_FAV);
    return Scaffold(
        appBar: AppBar(title: Text(OVERVIEW_APPBAR_FAV_TIT), actions: [
          PopupAppbar(allOption: true, favoriteOption: false),
          BadgeShopCartAppbar(controller.qtdeCartItems())
        ]),
        drawer: Drawwer(),
        body: Observer(
          builder: (_) => OverviewItemsGrid(controller.filteredProducts),
        ));
  }
}
