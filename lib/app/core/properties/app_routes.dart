import 'package:get/get.dart';

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
  static const OVERVIEW_DETAIL = '/item-details/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const INVENTORY = '/inventory';
  static const INVENTORY_ADDEDIT_PRODUCT = '/inventory-add-edit';

  // static const OVERVIEW_FAV = '/item-overview-favorites';

  static List<GetPage> getAppRoutes = [
    GetPage(
        name: OVERVIEW_ALL,
        // page: () => OverviewView(enumFilter: EnumFilter.All),
        page: () => OverviewView(),
        binding: OverviewBindings()),
    GetPage(
        name: ORDERS,
        page: () => OrdersView(controller: Get.find()),
        binding: OrdersBindings()),
    GetPage(
      // name: '$OVERVIEW_DETAIL_ROUTE:id',
      name: '$OVERVIEW_DETAIL',
      page: () => OverviewItemDetailsView(controller: Get.find()),
    ),
    GetPage(
      name: CART,
      page: () => CartView(controller: Get.find()),
      binding: CartBindings(),
    ),
    GetPage(
      name: INVENTORY,
      page: () => InventoryView(controller: Get.find()),
      binding: InventoryBindings(),
    ),
    GetPage(
      name: INVENTORY_ADDEDIT_PRODUCT,
      page: () => InventoryEditView(),
    ),
  ];
}