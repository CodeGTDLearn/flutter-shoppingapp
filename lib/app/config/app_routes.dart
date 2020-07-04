import 'package:get/get.dart';

import '../modules/cart/cart_page.dart';
import '../modules/managed_products/pages/managed_product_edit_page.dart';
import '../modules/managed_products/pages/managed_products_page.dart';
import '../modules/orders/orders_page.dart';
import '../modules/overview/components/popup_appbar_enum.dart';
import '../modules/overview/pages/overview_page.dart';

const OVERVIEW_ALL_ROUTE = '/';
const OVERVIEW_FAV_ROUTE = '/item-overview-favorites';
const CART_ROUTE = '/cart';
const ORDERS_ROUTE = '/orders';
const MAN_PROD_ROUTE = '/managed-products';
const MAN_PROD_ADD_EDIT_ROUTE = '/managed-product-add-edit';
const OVERVIEW_DETAIL_ROUTE = '/item-details';

List<GetPage> getAppRoutes = [
  GetPage(name: OVERVIEW_ALL_ROUTE, page: () => OverviewPage(PopupEnum.All)),
  GetPage(name: OVERVIEW_FAV_ROUTE, page: () => OverviewPage(PopupEnum.Fav)),
  GetPage(name: CART_ROUTE, page: () => CartPage()),
  GetPage(name: ORDERS_ROUTE, page: () => OrdersPage()),
  GetPage(name: MAN_PROD_ROUTE, page: () => ManagedProductsPage()),
  GetPage(name: MAN_PROD_ADD_EDIT_ROUTE, page: () => ManagedProductEditPage()),
];
