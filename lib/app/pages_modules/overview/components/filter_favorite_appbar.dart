import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/texts_icons_provider/app_generic_words.dart';

import '../../../core/properties/app_routes.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';
import 'filter_favorite_enum.dart';

// ignore: must_be_immutable
class FilterFavoriteAppbar extends StatelessWidget {
  final EnumFilter _enum;

  FilterFavoriteAppbar(this._enum);

  final OverviewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_FAV, key: Key(K_OV08)),
                  value: EnumFilter.Fav,
                  enabled: _enum == EnumFilter.All),
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_ALL, key: Key(K_OV09)),
                  value: EnumFilter.All,
                  enabled: _enum == EnumFilter.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              // ? SimpleSnackbar(NO_FAVS_YET, context).show()
              ? Get.snackbar(OPS, NO_FAVS_YET)
              : Get.toNamed(value == EnumFilter.All
                  ? AppRoutes.OVERVIEW_ALL
                  : AppRoutes.OVERVIEW_FAV);
        });
  }
}
