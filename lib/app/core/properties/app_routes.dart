import 'package:get/get.dart';

import '../../pages_modules/cart/core/cart_bindings.dart';
import '../../pages_modules/cart/page/cart_page.dart';
import '../../pages_modules/managed_products/core/managed_products_bindings.dart';
import '../../pages_modules/managed_products/pages/managed_product_add_edit_page.dart';
import '../../pages_modules/managed_products/pages/managed_products_page.dart';
import '../../pages_modules/orders/core/orders_bindings.dart';
import '../../pages_modules/orders/pages/orders_page.dart';
import '../../pages_modules/overview/components/filter_favorite_enum.dart';
import '../../pages_modules/overview/core/overview_bindings.dart';
import '../../pages_modules/overview/pages/overview_item_details_page.dart';
import '../../pages_modules/overview/pages/overview_page.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const OVERVIEW_ALL = '/';
  static const OVERVIEW_FAV = '/item-overview-favorites';
  static const OVERVIEW_DETAIL = '/item-details/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const MAN_PROD = '/managed-products';
  static const MAN_PROD_ADD_EDIT = '/managed-product-add-edit';

  static List<GetPage> getAppRoutes = [
    GetPage(
        name: OVERVIEW_ALL,
        page: () => OverviewPage(EnumFilter.All),
        binding: OverviewBindings()),
    GetPage(
        name: OVERVIEW_FAV,
        page: () => OverviewPage(EnumFilter.Fav),
        binding: OverviewBindings()),
    GetPage(
        name: ORDERS,
        page: () => OrdersPage(),
        binding: OrdersBindings()),
    GetPage(
      // name: '$OVERVIEW_DETAIL_ROUTE:id',
      name: '$OVERVIEW_DETAIL',
      page: () => OverviewItemDetailsPage(),
    ),
    GetPage(
      name: CART,
      page: () => CartPage(),
      binding: CartBindings(),
    ),
    GetPage(
      name: MAN_PROD,
      page: () => ManagedProductsPage(),
      binding: ManagedProductsBindings(),
    ),
    GetPage(
      name: MAN_PROD_ADD_EDIT,
      page: () => ManagedProductAddEditPage(),
    ),
  ];
}
