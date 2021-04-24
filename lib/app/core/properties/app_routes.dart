import 'package:get/get.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/cart/view/cart_view.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/inventory/view/inventory_add_edit_view.dart';
import '../../modules/inventory/view/inventory_view.dart';
import '../../modules/orders/core/orders_bindings.dart';
import '../../modules/orders/view/orders_view.dart';
import '../../modules/overview/components/filter_favorite_enum.dart';
import '../../modules/overview/core/overview_bindings.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../../modules/overview/view/overview_view.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const OVERVIEW_ALL = '/';
  static const OVERVIEW_FAV = '/item-overview-favorites';
  static const OVERVIEW_DETAIL = '/item-details/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const MANAGED_PRODUCTS = '/managed-products';
  static const MANAGED_PRODUCTS_ADDEDIT_PAGE = '/managed-product-add-edit';

  static List<GetPage> getAppRoutes = [
    GetPage(
        name: OVERVIEW_ALL,
        page: () => OverviewView(enumFilter: EnumFilter.All),
        binding: OverviewBindings()),
    GetPage(
        name: OVERVIEW_FAV,
        page: () => OverviewView(enumFilter: EnumFilter.Fav),
        binding: OverviewBindings()),
    GetPage(
        name: ORDERS,
        page: () => OrdersPage(controller: Get.find()),
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
      name: MANAGED_PRODUCTS,
      page: () => InventoryView(controller: Get.find()),
      binding: InventoryBindings(),
    ),
    GetPage(
      name: MANAGED_PRODUCTS_ADDEDIT_PAGE,
      page: () => InventoryAddEditView(),
    ),
  ];
}
