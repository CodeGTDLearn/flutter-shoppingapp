import 'package:get/route_manager.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/cart/view/cart_view.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/inventory/view/inventory_edit_view.dart';
import '../../modules/inventory/view/inventory_view.dart';
import '../../modules/orders/core/orders_bindings.dart';
import '../../modules/orders/view/orders_view.dart';
import '../../modules/overview/core/overview_bindings.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../../modules/overview/view/overview_view.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const OVERVIEW_ALL = '/';

  // '$OVERVIEW_DETAIL_ROUTE:id'
  // static const OVERVIEW_DETAIL = '/item-details/';
  static const OVERVIEW_DETAIL = '/item-details/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const INVENTORY = '/inventory';
  static const INVENTORY_EDIT_PRODUCT = '/inventory-edit';

  // @formatter:off
  static List<GetPage> getAppRoutes = [
    GetPage(name: OVERVIEW_ALL, page: () => OverviewView(), binding: OverviewBindings()),

    GetPage(name: '$OVERVIEW_DETAIL:id', page: () => OverviewItemDetailsView()),

    GetPage(name: ORDERS, page: () => OrdersView(), binding: OrdersBindings()),

    GetPage(name: CART, page: () => CartView(), binding: CartBindings()),

    GetPage(name: INVENTORY, page: () => InventoryView(), binding: InventoryBindings()),

    GetPage(name: '$INVENTORY_EDIT_PRODUCT:id', page: () => InventoryEditView()),
  ];
  // @formatter:on
}
// GetPage(
//   name: '$OVERVIEW_DETAIL',
//   page: () => OverviewItemDetailsView(),
// ),
// Get.toNamed('$OVERVIEW_DETAIL_ROUTE${_product.id}'),
// String? id = Get.arguments;