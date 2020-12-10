import 'package:flutter/material.dart';
import 'package:shopingapp/app/pages_modules/overview/components/badge_shop_cart_appbar.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_appbar.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_texts_icons_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';

import '../managed_products/core/managed_products_widget_keys.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EnumFilter enumFilter;

  CustomAppBar({this.enumFilter});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: Key(APPBAR_DRW),
      title: Text(
        enumFilter == EnumFilter.All ? OV_TIT_ALL_APPBAR : OV_TIT_FAV_APPBAR,
        key: Key(OV05),
      ),
      actions: [FilterFavoriteAppbar(enumFilter), BadgeShopCartAppbar()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
