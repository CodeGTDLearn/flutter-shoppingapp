import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/app_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/repo/cart_repo_firebase.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../app/modules/orders/repo/orders_mocked_repo.dart';
import '../../app/modules/orders/repo/orders_mocked_repo_emptydb.dart';
import '../../app/modules/overview/repo/overview_mocked_repo.dart';

class OrdersTestBindings {
  final IOrdersRepo _mocked_repo_tobe_used = OrdersMockedRepo();

  void _bindingsBuilder(IOrdersRepo ordersRepo) {
    Get.reset();

    expect(Get.isPrepared<AppThemeController>(), isFalse);

    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);

    expect(Get.isPrepared<IOrdersRepo>(), isFalse);
    expect(Get.isPrepared<IOrdersService>(), isFalse);
    expect(Get.isPrepared<OrdersController>(), isFalse);

    expect(Get.isPrepared<ICartRepo>(), isFalse);
    expect(Get.isPrepared<ICartService>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<AppThemeController>(() => AppThemeController());

      //OVERVIEW
      Get.lazyPut<IOverviewRepo>(() => OverviewMockedRepo());
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      //ORDERS
      Get.lazyPut<IOrdersRepo>(() => ordersRepo);
      Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));
      Get.lazyPut<OrdersController>(
          () => OrdersController(service: Get.find<IOrdersService>()));

      //CART
      Get.lazyPut<ICartRepo>(() => CartRepoFirebase());
      Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));
      Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>()));
    });

    binding.builder();

    expect(Get.isPrepared<AppThemeController>(), isTrue);

    expect(Get.isPrepared<IOverviewRepo>(), isTrue);
    expect(Get.isPrepared<IOverviewService>(), isTrue);
    expect(Get.isPrepared<OverviewController>(), isTrue);

    expect(Get.isPrepared<IOrdersRepo>(), isTrue);
    expect(Get.isPrepared<IOrdersService>(), isTrue);
    expect(Get.isPrepared<OrdersController>(), isTrue);

    expect(Get.isPrepared<ICartRepo>(), isTrue);
    expect(Get.isPrepared<ICartService>(), isTrue);
    expect(Get.isPrepared<CartController>(), isTrue);

    HttpOverrides.global = null;
  }

  void bindingsBuilderMockedRepo({required bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(_mocked_repo_tobe_used);
  }

  void bindingsBuilderMockRepoEmptyDb({required bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(OrdersMockedRepoEmptyDb());
  }
}
