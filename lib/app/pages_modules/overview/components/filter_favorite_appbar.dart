import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../core/overview_widget_keys.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import 'filter_favorite_enum.dart';

// ignore: must_be_immutable
class FilterFavoriteAppbar extends StatelessWidget {
  final EnumFilter _enum;

  FilterFavoriteAppbar(this._enum);

  final OverviewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_FAV),
                  value: EnumFilter.Fav,
                  enabled: _enum == EnumFilter.All),
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_ALL),
                  value: EnumFilter.All,
                  enabled: _enum == EnumFilter.Fav)
            ],
        key: Key(OV006),
        onSelected: (value) => Get.toNamed(value == EnumFilter.All
            ? AppRoutes.OVERVIEW_ALL
            : _controller.getFavoritesQtde() == 0
                ? CustomSnackBar.simple(OPS, NO_FAVS_YET)
                : AppRoutes.OVERVIEW_FAV));
  }
}
