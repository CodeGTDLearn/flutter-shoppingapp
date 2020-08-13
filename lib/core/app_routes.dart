import 'package:get/get.dart';

import '../modules/cart/cart_bindings.dart';
import '../modules/cart/page/cart_page.dart';
import '../modules/managed_products/managed_products_bindings.dart';
import '../modules/managed_products/pages/managed_product_edit_page.dart';
import '../modules/managed_products/pages/managed_products_page.dart';
import '../modules/orders/orders_bindings.dart';
import '../modules/orders/pages/orders_page.dart';
import '../modules/overview/components/popup_appbar_enum.dart';
import '../modules/overview/overview_bindings.dart';
import '../modules/overview/pages/overview_item_details_page.dart';
import '../modules/overview/pages/overview_page.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const OVERVIEW_ALL_ROUTE = '/';
  static const OVERVIEW_FAV_ROUTE = '/item-overview-favorites';
  static const OVERVIEW_DETAIL_ROUTE = '/item-details/';
  static const CART_ROUTE = '/cart';
  static const ORDERS_ROUTE = '/orders';
  static const MAN_PROD_ROUTE = '/managed-products';
  static const MAN_PROD_ADD_EDIT_ROUTE = '/managed-product-add-edit';

  static List<GetPage> getAppRoutes = [
    GetPage(
        name: OVERVIEW_ALL_ROUTE,
        page: () => OverviewPage(Popup.All),
        binding: OverviewBindings()),
    GetPage(
        name: OVERVIEW_FAV_ROUTE,
        page: () => OverviewPage(Popup.Fav),
        binding: OverviewBindings()),
    GetPage(
        name: ORDERS_ROUTE,
        page: () => OrdersPage(),
        binding: OrdersBindings()),
    GetPage(
      name: '$OVERVIEW_DETAIL_ROUTE:id',
      page: () => OverviewItemDetailsPage(),
    ),
    GetPage(
      name: CART_ROUTE,
      page: () => CartPage(),
      binding: CartBindings(),
    ),
    GetPage(
      name: MAN_PROD_ROUTE,
      page: () => ManagedProductsPage(),
      binding: ManagedProductsBindings(),
    ),
    GetPage(
      name: MAN_PROD_ADD_EDIT_ROUTE,
      page: () => ManagedProductEditPage(),
    ),
  ];
}
