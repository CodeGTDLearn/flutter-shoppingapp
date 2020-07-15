import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../overview_controller.dart';
import 'popup_appbar_enum.dart';

// ignore: must_be_immutable
class PopupAppbar extends StatelessWidget {

  final Popup _enum;

  PopupAppbar(this._enum);

  final OverviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_FAV),
                  value: Popup.Fav,
                  enabled: _enum == Popup.All),
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_ALL),
                  value: Popup.All,
                  enabled: _enum == Popup.Fav)
            ],
        onSelected: (value) => Get.toNamed(
            value == Popup.All ? OVERVIEW_ALL_ROUTE : OVERVIEW_FAV_ROUTE));
  }
}
