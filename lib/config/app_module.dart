// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/cartRepo.dart';
import 'package:shopingapp/repositories/cartRepoInt.dart';
import 'package:shopingapp/repositories/ordersRepoInt.dart';
import 'package:shopingapp/repositories/productsRepoInt.dart';
import 'package:shopingapp/repositories/ordersRepo.dart';
import 'package:shopingapp/repositories/productsRepo.dart';
import 'package:shopingapp/service_stores/itemsOverviewGridProductItemStore.dart';
import 'package:shopingapp/service_stores/itemsOverviewGridProductsStore.dart';
import 'package:shopingapp/service_stores/cartStore.dart';
import 'package:shopingapp/service_stores/orderCollapsableTileStore.dart';
import 'package:shopingapp/service_stores/ordersStore.dart';
import 'package:shopingapp/views/cartView.dart';

import 'package:shopingapp/views/itemDetailView.dart';
import 'package:shopingapp/views/itemsOverviewFavView.dart';
import 'package:shopingapp/views/itemsOverviewView.dart';
import 'package:shopingapp/views/orderView.dart';

import '../app_driver.dart';
import 'appProperties.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        //REPOSITORIES
        Bind<CartRepoInt>((i) => CartRepo()),
        Bind<ProductsRepoInt>((i) => ProductsRepo()),

        //SERVICE_STORES
        Bind<ItemsOverviewGridProductsStoreInt>((i) => ItemsOverviewGridProductsStore()),
        Bind<ItemsOverviewGridProductItemStoreInt>((i) => ItemsOverviewGridProductItemStore(),
            singleton: false),
        Bind<CartStoreInt>((i) => CartStore()),
        Bind<OrdersRepoInt>((i) => OrdersRepo()),
        Bind<OrdersStoreInt>((i) => OrdersStore()),
        Bind<OrderCollapsableTileStoreInt>((i) => OrderCollapsableTileStore(), singleton: false),
        Bind((i) => Product),
      ];

  @override
  List<Router> get routers => [
        Router(RT_OVERV_VIEW, child: (_, args) => ItemsOverviewView()),
        Router(RT_OVERV_FAV_VIEW,
            child: (_, args) => ItemsOverviewFavView(), transition: TransitionType.noTransition),
        Router(RT_CART, child: (_, args) => CartView()),
        Router(RT_ORDERS, child: (_, args) => OrderView()),
        Router(RT_ITEM_DETAILS + ':id', child: (_, args) => ItemDetailView(args.params['id'])),
      ];

  @override
  Widget get bootstrap => AppDriver();
}
