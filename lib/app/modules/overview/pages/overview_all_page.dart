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

class OverviewAllPage extends StatefulWidget {
  @override
  _OverviewAllPageState createState() => _OverviewAllPageState();
}

class _OverviewAllPageState
    extends ModularState<OverviewAllPage, OverviewController> {
  @override
  void initState() {
    controller.applyFilter(PopupAppbarEnum.All);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_ITEMSOVERVIEW_ALL);
    return Scaffold(
        appBar: AppBar(
          title: Text(OVERVIEW_APPBAR_ALL_TIT),
          actions: [
            PopupAppbar(allOption: false, favoriteOption: true),
            Observer(
                builder: (BuildContext _) =>
                    BadgeShopCartAppbar(controller.qtdeCartItems()))
          ],
        ),
        drawer: Drawwer(),
        body: Observer(
          builder: (_) => OverviewItemsGrid(controller.filteredProducts),
        ));
  }
}
