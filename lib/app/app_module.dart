// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_driver.dart';
import 'config/app_routes.dart';
import 'modules/cart/cart_controller.dart';
import 'modules/cart/cart_module.dart';
import 'modules/core/app_theme/app_theme.dart';
import 'modules/core/app_theme/app_theme_store.dart';
import 'modules/core/shared_preferences/shared_preferences_repo.dart';
import 'modules/managed_products/managed_products_controller.dart';
import 'modules/managed_products/managed_products_module.dart';
import 'modules/orders/orders_module.dart';
import 'modules/overview/overview_module.dart'; // ignore: directives_ordering

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<AppTheme>((i) => AppTheme()),
        Bind<SharedPreferencesRepo>((i) => SharedPreferencesRepo()),

        //ERRO: ESSES CONTROLERS DEVERIAM ESTAR EM SEUS RESPECTIVOS MODULOS
        Bind((i) => ManagedProductsController()),
        Bind((i) => CartController()),
//        Bind((i) => OverviewItemService(), singleton: false),

        //STORES
        Bind<AppThemeStore>((i) => AppThemeStore()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: OverviewModule()),
        Router(ITEMSOVER_FAV_ROUTE, module: OverviewModule()),
        Router(CART_ROUTE, module: CartModule()),
        Router(ORDERS_ROUTE, module: OrdersModule()),
        Router(MANAGPRODUCT_ROUTE, module: ManagedProductsModule())
      ];

  @override
  Widget get bootstrap => AppDriver();

  static Inject get to => Inject<AppModule>.of();
}
