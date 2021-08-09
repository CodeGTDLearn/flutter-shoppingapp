import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/repo/cart_repo_http.dart';
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
import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/orders/repo/orders_mocked_repo.dart';
import '../../app/modules/overview/repo/overview_mocked_repo.dart';

class OrdersTestTitles {
  String REPO_NAME = 'OrdersMockedRepo';

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get ORDERS_GROUP_TITLE => 'Orders|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TEST_TITLE => '$REPO_NAME|Repo: Unit';
  get SERVICE_TEST_TITLE => '$REPO_NAME|Service: Unit';
  get CONTROLLER_TEST_TITLE => '$REPO_NAME|Controller: Integr';
  get VIEW_TEST_TITLE => '$REPO_NAME|View: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get check_emptyView_noOrderInDb => 'Empty View - No Orders in DB';
  get check_orders_with_one_orderInDB => 'Opening View with One ORDER in DB';
  get tap_viewBackButton => 'Testing View BackButton';
  get ordering_inCartView_tapping_OrderNowButton =>
      'Ordering from CartView - Taping OrderNow Button';
  // @formatter:on
}
