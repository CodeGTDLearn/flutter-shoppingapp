// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/entities_models/Product.dart';
import 'package:shopingapp/repositories/CartRepo.dart';
import 'package:shopingapp/repositories/CartRepoInt.dart';
import 'package:shopingapp/repositories/OrdersRepoInt.dart';
import 'package:shopingapp/repositories/ProductsRepoInt.dart';
import 'package:shopingapp/repositories/OrdersRepo.dart';
import 'package:shopingapp/repositories/ProductsRepo.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductItemStore.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/service_stores/OrderCollapsableTileStore.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/views/CartView.dart';

import 'package:shopingapp/views/ItemDetailView.dart';
import 'package:shopingapp/views/ItemsOverviewFavView.dart';
import 'package:shopingapp/views/ItemsOverviewView.dart';
import 'package:shopingapp/views/OrderView.dart';

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
