import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/properties/app_properties.dart';
import '../../core/properties/app_routes.dart';
import '../../core/properties/theme/dark_theme_controller.dart';
import '../cart/service/i_cart_service.dart';
import '../managed_products/controller/managed_products_controller.dart';
import '../orders/service/i_orders_service.dart';
import 'app_messages_provided.dart';
import 'core/texts_icons/drawwer_texts_icons_provided.dart';
import 'custom_snackbar.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  BuildContext _context;
  final ICartService _cart = Get.find();
  final IOrdersService _orders = Get.find();
  final ManagedProductsController _managedProducts = Get.find();
  final DarkThemeController _darkThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TIT_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(
        quantityItems: _managedProducts.managedProductsQtde(),
        leadIcon: DRW_ICO_PROD,
        title: DRW_LBL_PROD,
        message: DRW_NO_DATA,
        route: AppRoutes.OVERVIEW_ALL,
        notRoutingWithoutQtdeEvaluation: false,
        // quitPopping: true,
      ),
      _drawerItem(
        quantityItems: _cart.cartItemsQtde(),
        leadIcon: DRW_ICO_CART,
        title: DRW_LBL_CART,
        message: DRW_TXT_CART,
        route: AppRoutes.CART,
        notRoutingWithoutQtdeEvaluation: true,
        // quitPopping: false,
      ),
      _drawerItem(
        quantityItems: _orders.ordersQtde(),
        leadIcon: DRW_ICO_ORD,
        title: DRW_LBL_ORD,
        message: DRW_TXT_ORD,
        route: AppRoutes.ORDERS,
        notRoutingWithoutQtdeEvaluation: false,
        // quitPopping: false,
      ),
      _drawerItem(
        quantityItems: _managedProducts.managedProductsQtde(),
        leadIcon: DRW_ICO_MAN_PROD,
        title: DRW_LBL_MAN_PROD,
        message: DRW_TXT_NO_MAN_PROD_YET,
        route: AppRoutes.MANAGED_PRODUCTS,
        notRoutingWithoutQtdeEvaluation: false,
        // quitPopping: false
      ),
      Obx(() => SwitchListTile(
          secondary: DRW_ICO_DARKTHM,
          title: Text(DRW_LBL_DARKTHM),
          value: _darkThemeController.isDark.value,
          onChanged: _darkThemeController.toggleDarkTheme))
    ]));
  }

  ListTile _drawerItem(
      {int quantityItems,
      Icon leadIcon,
      String title,
      String message,
      String route,
      bool notRoutingWithoutQtdeEvaluation}) {
    // bool quitPopping}) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (quantityItems == 0 && notRoutingWithoutQtdeEvaluation) {
            // CustomSnackbar.simple(
            //   message: message,
            //   context: _context,
            //   duration: DURATION,
            // );
            SimpleSnackbar(message, _context,DURATION).show();

          } else if (quantityItems != 0 && notRoutingWithoutQtdeEvaluation) {
            Get.toNamed(route);
            // quitPopping ? Get.offNamed(route) : Get.toNamed(route);
          } else {
            Get.toNamed(route);
            // quitPopping ? Get.offNamed(route) : Get.toNamed(route);
          }
        });
  }
}
