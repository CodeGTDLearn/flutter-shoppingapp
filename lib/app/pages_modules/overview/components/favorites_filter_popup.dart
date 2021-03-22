import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';
import 'filter_favorite_enum.dart';

// ignore: must_be_immutable
class FavoritesFilterPopup extends StatelessWidget {
  final EnumFilter _enum;
  final OverviewController _controller = Get.find();

  FavoritesFilterPopup(this._enum);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_FAV, key: Key(K_OV_FLT_FAV)),
                  value: EnumFilter.Fav,
                  enabled: _enum == EnumFilter.All),
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_ALL, key: Key(K_OV_FLT_ALL)),
                  value: EnumFilter.All,
                  enabled: _enum == EnumFilter.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar(OPS, NO_FAVS_YET).show()
              : Get.toNamed(value == EnumFilter.All
                  ? AppRoutes.OVERVIEW_ALL
                  : AppRoutes.OVERVIEW_FAV);
        });
  }
}
