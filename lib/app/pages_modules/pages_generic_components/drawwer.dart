import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/properties/app_properties.dart';
import '../../core/properties/app_routes.dart';
import '../../core/properties/theme/dark_theme_controller.dart';
import '../../texts_icons_provider/app_generic_words.dart';
import '../cart/service/i_cart_service.dart';
import '../managed_products/service/i_managed_products_service.dart';
import '../orders/service/i_orders_service.dart';
import 'core/message_db_empty_provided.dart';
import 'core/texts_icons_provided/drawwer_texts_icons_provided.dart';
import 'custom_flush_notifier.dart';

// ignore: must_be_immutable
class Drawwer extends StatelessWidget {
  BuildContext _context;
  final ICartService _cart = Get.find();
  final IOrdersService _orders = Get.find();
  final IManagedProductsService _manProd = Get.find();
  final DarkThemeController _darkThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TIT_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(_manProd.managedProductsQtde(), DRW_ICO_PROD, DRW_LBL_PROD,
          DRW_NO_DATA, AppRoutes.OVERVIEW_ALL_ROUTE, false),
//      _drawerItem(
//        _cart.cartItemsQtde().asStream().length,
//        DRAWER_ICO_CART,
//        DRAWER_LBL_CART,
//        FLUSHNOTIF_MSG_CART_EMPTY,
//        AppRoutes.CART_ROUTE,
//        false,
//      ),
//      _drawerItem(
//        _orders.ordersQtde().asStream().length,
//        DRAWER_ICO_ORDERS ,
//        DRAWER_LBL_ORDERS ,
//        FLUSHNOTIF_MSG_NOORDER,
//        AppRoutes.ORDERS_ROUTE,
//        false,
//      ),
      _drawerItem(
        _manProd.managedProductsQtde(),
        DRW_ICO_MAN_PROD,
        DRW_LBL_MAN_PROD,
        DRW_TXT_NO_MAN_PROD_YET,
        AppRoutes.MAN_PROD_ROUTE,
        true,
      ),
      Obx(() => SwitchListTile(
          secondary: DRW_ICO_DARKTHM,
          title: Text(DRW_LBL_DARKTHM),
          value: _darkThemeController.isDark.value,
          onChanged: _darkThemeController.toggleDarkTheme))
    ]));
  }

  ListTile _drawerItem(
    int quantityItems,
    Icon leadIcon,
    String title,
    String message,
    String route,
    bool isNotAllowedAccessTheRouteWithoutQtdeEvaluation,
  ) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (quantityItems == 0 &&
              isNotAllowedAccessTheRouteWithoutQtdeEvaluation) {
            FlushNotifier(OPS, message, INTERVAL, _context).simple();
          } else if (quantityItems != 0 &&
              isNotAllowedAccessTheRouteWithoutQtdeEvaluation) {
            Get.toNamed(route);
//          } else if (isAllowedAccessTheRouteWithoutQtdeEvaluation) {
          } else {
            Get.toNamed(route);
          }
        });
  }
}
