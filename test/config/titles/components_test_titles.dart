import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/overview/repo/overview_mocked_repo.dart';

class ComponentsTestTitles {
  get DRAWWER_TEST_TITLE => 'Components|Drawer: Functional';

  get PROGR_IND_TEST_TITLE => 'Components|ProgresIndic: Functional';
}
