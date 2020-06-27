import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/overview/components/badge_shop_cart_appbar.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../../core/components/drawwer.dart';
import '../components/overview_grid.dart';
import '../components/popup_appbar.dart';
import '../components/popup_appbar_enum.dart';
import '../overview_controller.dart';

class OverviewPage extends StatefulWidget {
  final PopupEnum popupEnum;

  OverviewPage(this.popupEnum);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState
    extends ModularState<OverviewPage, OverviewController> {
  @override
  void initState() {
    controller.applyFilter(widget.popupEnum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.applyFilter(widget.popupEnum);
    print(MON_BUILD_ITEMSOVERVIEW);
    return Scaffold(
      appBar: AppBar(
        title: Text(OVERVIEW_APPBAR_ALL_TIT),
        actions: [
          PopupAppbar(allOption: false, favoriteOption: true),
          BadgeShopCartAppbar()
        ],
      ),
      drawer: Drawwer(),
      body: Observer(builder: (_) => OverviewGrid(controller.filteredProducts)),
    );
  }
}
