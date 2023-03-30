import 'dart:io';

import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/texts/core_labels.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_labels.dart';
import 'package:shopingapp/app/modules/cart/repo/cart_repo_memory.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_bindings.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../orders/repo/orders_mocked_repo.dart';
import '../../overview/repo/overview_mocked_repo.dart';

class CartTestBindings {
  final ICartRepo _mocked_repo = CartRepoMemory();

  void _bindingsBuilder(ICartRepo cartRepo) {
    Get.reset();

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(OverviewMockedRepo.new);
      Get.lazyPut<IOverviewService>(
        () => OverviewService(repo: Get.find<IOverviewRepo>()),
      );
      Get.lazyPut(() => OverviewController(service: Get.find<IOverviewService>()));

      Get.lazyPut<IOrdersRepo>(OrdersMockedRepo.new);
      Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));

      InventoryBindings().dependencies();

      Get.lazyPut(CartLabels.new);
      Get.lazyPut(CoreLabels.new);
      Get.lazyPut<ICartRepo>(() => cartRepo);
      Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));
      Get.lazyPut(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>()));
    });

    binding.builder();

    HttpOverrides.global = null;
  }

  void bindingsBuilder({required bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(_mocked_repo);
  }
}