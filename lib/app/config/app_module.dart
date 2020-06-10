// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/cart/cart_module.dart';
import 'package:shopingapp/app/modules/core/app_theme/app_theme.dart';
import 'package:shopingapp/app/modules/core/app_theme/app_theme_store.dart';
import 'package:shopingapp/app/modules/core/shared_preferences/shared_preferences_repo.dart';
import 'package:shopingapp/app/modules/managed_products/managed_products_module.dart';
import 'package:shopingapp/app/modules/orders/orders_module.dart';
import 'package:shopingapp/app/modules/overview/overview_module.dart';

import '../app_driver.dart';
import 'app_routes.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<AppTheme>((i) => AppTheme()),
        Bind<SharedPreferencesRepo>((i) => SharedPreferencesRepo()),

        //STORES
        Bind<AppThemeStoreBase>((i) => AppThemeStore()),
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
