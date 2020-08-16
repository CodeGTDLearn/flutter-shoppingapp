import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../controller/overview_controller.dart';
import '../core/overview_texts_icons_provided.dart';
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
                  child: Text(OVERV_TXT_POPUP_FAV),
                  value: Popup.Fav,
                  enabled: _enum == Popup.All),
              PopupMenuItem(
                  child: Text(OVERV_TXT_POPUP_ALL),
                  value: Popup.All,
                  enabled: _enum == Popup.Fav)
            ],
        onSelected: (value) => Get.toNamed(value == Popup.All
            ? AppRoutes.OVERVIEW_ALL_ROUTE
            : AppRoutes.OVERVIEW_FAV_ROUTE));
  }
}
