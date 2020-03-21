// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app_driver.dart';
import 'appProperties.dart';

class AppModule extends MainModule {

  // here wxxill be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
//    Router(ROUTE_OVERVIEW, child: (_, args) => ProductsOverviewScr()),
//    Router(ROUTE_PROD_DETAILS, child: (_, args) => ProductDetailScr()),
//    Router(ROUTE_CART, child: (_, args) => CartScreen()),
//    Router(ROUTE_ORDERS, child: (_, args) => OrdersScreen()),
  ];

// add your main widget here
  @override
  Widget get bootstrap => AppDriver();
}