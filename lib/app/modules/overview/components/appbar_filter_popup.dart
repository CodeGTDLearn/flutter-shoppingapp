import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/snackbar/simple_snackbar.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';
import 'filter_favorite_enum.dart';

// ignore: must_be_immutable
class AppbarFilterPopup extends StatelessWidget {
  final OverviewController _controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(K_OV_FLT_FAV),
                  child: Text(OV_TXT_POPUP_FAV),
                  value: EnumFilter.Fav),
              // enabled: _enum == EnumFilter.All),
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_ALL, key: Key(K_OV_FLT_ALL)),
                  value: EnumFilter.All),
              // enabled: _enum == EnumFilter.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar(OPS, OVERVIEW_NO_ITEMS_FAVS_YET).show()
              : value == EnumFilter.All
                  ? _controller.setProductsByFilter(EnumFilter.All)
                  : _controller.setProductsByFilter(EnumFilter.Fav);
        });
  }
}
