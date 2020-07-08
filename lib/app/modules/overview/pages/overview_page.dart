import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/titles_icons/views/overview.dart';
import '../../core/components/drawwer.dart';
import '../components/badge_shop_cart_appbar.dart';
import '../components/overview_grid.dart';
import '../components/popup_appbar.dart';
import '../components/popup_appbar_enum.dart';
import '../overview_controller.dart';

class OverviewPage extends StatelessWidget {
  final Popup _enum;
  final _controller = Get.put(OverviewController());

  OverviewPage(this._enum);

  Widget build(BuildContext context) {
    _controller.applyFilter(_enum);
    return Scaffold(
      appBar: AppBar(
        title: Text(OVERVIEW_APPBAR_ALL_TIT),
        actions: [
          PopupAppbar(allOption: false, favoriteOption: true),
          BadgeShopCartAppbar()
        ],
      ),
      drawer: Drawwer(),
      body: OverviewGrid(),
    );
  }
}
