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
  static const MANAGED_PRODUCTS = '/managed-products';
  static const MANAGED_PRODUCTS_ADDEDIT_PAGE = '/managed-product-add-edit';

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
        page: () => OrdersPage(controller: Get.find()),
        binding: OrdersBindings()),
    GetPage(
      // name: '$OVERVIEW_DETAIL_ROUTE:id',
      name: '$OVERVIEW_DETAIL',
      page: () => OverviewItemDetailsPage(controller: Get.find()),
    ),
    GetPage(
      name: CART,
      page: () => CartPage(controller: Get.find()),
      binding: CartBindings(),
    ),
    GetPage(
      name: MANAGED_PRODUCTS,
      page: () => ManagedProductsPage(controller: Get.find()),
      binding: ManagedProductsBindings(),
    ),
    GetPage(
      name: MANAGED_PRODUCTS_ADDEDIT_PAGE,
      page: () => ManagedProductAddEditPage(),
    ),
  ];
}
