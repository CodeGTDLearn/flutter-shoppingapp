import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/components/drawwer.dart';
import '../../core/configurable/textual_interaction/titles_icons/views/overview.dart';
import '../components/badge_shop_cart_appbar.dart';
import '../components/overview_grid.dart';
import '../components/popup_appbar.dart';
import '../components/popup_appbar_enum.dart';
import '../overview_controller.dart';

class OverviewPage extends StatelessWidget {
  final Popup _enum;

  final OverviewController _controller = Get.find();

  OverviewPage(this._enum);

  Widget build(BuildContext context) {
    _controller.applyFilter(_enum);
    return Scaffold(
      appBar: AppBar(
        title: Text(OVERVIEW_TIT_ALL_APPBAR),
        actions: [
          PopupAppbar(_enum),
          BadgeShopCartAppbar()
        ],
      ),
      drawer: Drawwer(),
      body: OverviewGrid(),
    );
  }
}
