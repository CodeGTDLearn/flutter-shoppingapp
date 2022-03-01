import 'package:get/route_manager.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/cart/view/cart_view.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/inventory/view/inventory_details_view.dart';
import '../../modules/inventory/view/inventory_product_zoom_view.dart';
import '../../modules/inventory/view/inventory_view.dart';
import '../../modules/orders/core/orders_bindings.dart';
import '../../modules/orders/view/orders_view.dart';
import '../../modules/overview/core/bindings/overview_bindings.dart';
import '../../modules/overview/core/bindings/overview_scaffold_bindings.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../../modules/overview/view/overview_view.dart';
import '../components/appbar/core_appbars_bindings.dart';
import '../components/drawer/core_drawer_bindings.dart';
import '../local_storage/local_storage_bindings.dart';
import '../utils/core_utils_bindings.dart';
import 'core_routes.dart';

// ignore: avoid_classes_with_only_static_members
class CoreRouter {
   // @formatter:off
  static List<GetPage> getAppRoutes = [
    GetPage(name: CoreRoutes.OVERVIEW_ALL, page: () => OverviewView(), bindings: [
      CoreUtilsBindings(),
      LocalStorageBindings(),
      CoreDrawerBindings(),
      CoreAppbarsBindings(),
      OverviewScaffoldBindings(),
      CartBindings(),
      OverviewBindings(),
    ]),

    GetPage(name: CoreRoutes.CART, page: () => CartView(), bindings: [
      CoreAppbarsBindings(),
      CoreUtilsBindings(),
      CartBindings()]),

    GetPage(name: '${CoreRoutes.OVERVIEW_ITEM_DETAILS}:id', page: () =>
        OverviewItemDetailsView()),

    GetPage(name: CoreRoutes.ORDERS, page: () => OrdersView(), bindings: [
      OrdersBindings()]),

    GetPage(name: CoreRoutes.INVENTORY, page: () => InventoryView(), bindings: [
      CoreAppbarsBindings(),
      CoreUtilsBindings(),
      OverviewBindings(),
      InventoryBindings()]),

    GetPage(name: '${CoreRoutes.INVENTORY_ITEM_DETAILS}:id', page: () =>
        InventoryDetailsView()),
    GetPage(name: '${CoreRoutes.INVENTORY_ITEM_IMAGE}', page: () => InventoryProductZoomView()),
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