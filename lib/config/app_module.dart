// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';
import 'package:shopingapp/repositories/products_repo.dart';
import 'package:shopingapp/service_stores/grid_products_serv_store.dart';
import 'package:shopingapp/service_stores/items_overview_serv_store.dart';
import 'package:shopingapp/views/cart_view.dart';
import 'package:shopingapp/views/items_overview_view.dart';

import '../app_driver.dart';
import 'appProperties.dart';

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [
        Bind((i) => ItemsOverviewServStore()),
        Bind((i) => GridProductsServStore()),
        Bind<IProductsRepo>((i) => ProductsRepo()),
      ];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(ROUTE_ITEM_OVERV_VIEW, child: (_, args) => ItemOverviewView()),
        Router(ROUTE_CART, child: (_, args) => CartView()),
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppDriver();
}
