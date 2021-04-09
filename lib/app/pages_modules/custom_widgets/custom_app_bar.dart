import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../overview/components/badge_shop_cart.dart';
import '../overview/components/favorites_filter_popup.dart';
import '../overview/components/filter_favorite_enum.dart';
import '../overview/core/overview_texts_icons_provided.dart';
import '../overview/core/overview_widget_keys.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EnumFilter enumFilter;

  CustomAppBar({this.enumFilter});

  Widget build(BuildContext context) {
    return AppBar(

        key: Key(K_DRW_APPBAR_BTN),
        title: Text(
            enumFilter == EnumFilter.All
                ? OV_TIT_ALL_APPBAR
                : OV_TIT_FAV_APPBAR,
            key: Key(K_OV_TIT_APPBAR)),
        actions: [FavoritesFilterPopup(enumFilter), BadgeShopCart()]);

  }
  Size get preferredSize => const Size.fromHeight(55);

}
