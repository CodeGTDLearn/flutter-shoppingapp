import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages_generic_components/drawwer.dart';
import '../components/badge_shop_cart_appbar.dart';
import '../components/overview_grid.dart';
import '../components/popup_appbar.dart';
import '../components/popup_appbar_enum.dart';
import '../controller/overview_controller.dart';
import '../core/overview_texts_icons_provided.dart';

class OverviewPage extends StatelessWidget {
  final Popup _enum;

  final OverviewController _controller = Get.find();

  OverviewPage(this._enum);

  Widget build(BuildContext context) {
    _controller.applyFilter(_enum);
    return Scaffold(
      appBar: AppBar(
        title: Text(_enum == Popup.All
            ? OVERV_TIT_ALL_APPBAR
            : OVERV_TIT_FAV_APPBAR),
        actions: [PopupAppbar(_enum), BadgeShopCartAppbar()],
      ),
      drawer: Drawwer(),
      body: OverviewGrid(),
    );
  }
}
