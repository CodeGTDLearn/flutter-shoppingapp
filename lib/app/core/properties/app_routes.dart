import 'package:get/route_manager.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/cart/view/cart_view.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/inventory/view/inventory_item_details_view.dart';
import '../../modules/inventory/view/inventory_item_image_view.dart';
import '../../modules/inventory/view/inventory_view.dart';
import '../../modules/orders/core/orders_bindings.dart';
import '../../modules/orders/view/orders_view.dart';
import '../../modules/overview/core/overview_bindings.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../../modules/overview/view/overview_view.dart';
import '../global_bindings/app_theme_bindings.dart';
import '../global_bindings/custom_appbars_binding.dart';
import '../global_bindings/custom_drawer_bindings.dart';
import '../global_bindings/custom_scaffolds_binding.dart';
import '../global_bindings/utils_bindings.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const OVERVIEW_ALL = '/';

  // '$OVERVIEW_DETAIL_ROUTE:id'
  // static const OVERVIEW_DETAIL = '/item-details/';
  static const OVERVIEW_ITEM_DETAILS = '/item-details/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const INVENTORY = '/inventory';
  static const INVENTORY_ITEM_DETAILS = '/inventory-item-edit/';
  static const INVENTORY_ITEM_IMAGE = '/inventory-item-image/';

  // @formatter:off
  static List<GetPage> getAppRoutes = [
    GetPage(name: OVERVIEW_ALL, page: () => OverviewView(), bindings: [
      UtilsBindings(),
      AppThemeBindings(),
      CustomDrawerBindings(),
      CustomAppbarsBinding(),
      CustomScaffoldBinding(),
      CartBindings(),
      OverviewBindings()]),

    GetPage(name: CART, page: () => CartView(), bindings: [
      CustomAppbarsBinding(),
      UtilsBindings(),
      CartBindings()]),

    GetPage(name: '$OVERVIEW_ITEM_DETAILS:id', page: () => OverviewItemDetailsView()),

    GetPage(name: ORDERS, page: () => OrdersView(), bindings: [
      CustomAppbarsBinding(),
      OrdersBindings()]),

    GetPage(name: INVENTORY, page: () => InventoryView(), bindings: [
      CustomAppbarsBinding(),
      UtilsBindings(),
      OverviewBindings(),
      InventoryBindings()]),

    GetPage(name: '$INVENTORY_ITEM_DETAILS:id', page: () => InventoryItemDetailsView()),
    GetPage(name: '$INVENTORY_ITEM_IMAGE', page: () => InventoryItemImageView()),
  ];
  // @formatter:on
}
// -------------------------- DO NOT REMOVE ------------------------------------
// GetPage(
//   name: '$OVERVIEW_DETAIL',
//   page: () => OverviewItemDetailsView(),
// ),
// Get.toNamed('$OVERVIEW_DETAIL_ROUTE${_product.id}'),
// String? id = Get.arguments;
// GetPage(
//   name: '$OVERVIEW_DETAIL',
//   page: () => OverviewItemDetailsView()),
// onPressed: () => Get.toNamed('${AppRoutes.INVENTORY_EDIT_PRODUCT}$_id'),
// onPressed: () => Get.toNamed('${AppRoutes.OVERVIEW_DETAIL_ROUTE$}$_id'),
// String? id = Get.arguments;
// if(_id == null) _id = Get.parameters['id'];