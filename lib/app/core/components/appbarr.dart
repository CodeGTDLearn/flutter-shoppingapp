import 'package:flutter/material.dart';

import '../../modules/overview/components/badge_shop_cart.dart';
import '../../modules/overview/components/favorites_filter_popup.dart';
import '../../modules/overview/components/filter_favorite_enum.dart';
import '../../modules/overview/core/overview_texts_icons_provided.dart';
import '../../modules/overview/core/overview_widget_keys.dart';

class AppBarr extends StatelessWidget implements PreferredSizeWidget {
  final EnumFilter enumFilter = EnumFilter.All;

  AppBarr({required enumFilter});

  Widget build(BuildContext context) {
    return AppBar(
        key: Key(K_DRW_APPBAR_BTN),
        title: Text(enumFilter == EnumFilter.All ? OV_TIT_ALL_APPBAR : OV_TIT_FAV_APPBAR,
            key: Key(K_OV_TIT_APPBAR)),
        actions: [FavoritesFilterPopup(enumFilter), BadgeShopCart()]);
  }

  Size get preferredSize => const Size.fromHeight(55);
}
