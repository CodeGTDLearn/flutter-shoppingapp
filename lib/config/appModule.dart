// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/service_stores/managedProductsStore.dart';
import 'package:shopingapp/views/managedProductsEditionView.dart';
import 'package:shopingapp/views/managedProductsView.dart';

import '../entities/product.dart';
import '../repositories/cartRepo.dart';
import '../repositories/cartRepoInt.dart';
import '../repositories/ordersRepoInt.dart';
import '../repositories/productsRepoInt.dart';
import '../repositories/ordersRepo.dart';
import '../repositories/productsRepo.dart';
import '../service_stores/itemsOverviewGridProductItemStore.dart';
import '../service_stores/itemsOverviewGridProductsStore.dart';
import '../service_stores/cartStore.dart';
import '../service_stores/orderCollapsableTileStore.dart';
import '../service_stores/ordersStore.dart';
import '../views/cartView.dart';

import '../views/itemDetailView.dart';
import '../views/itemsOverviewFavView.dart';
import '../views/ItemsOverviewAllView.dart';
import '../views/orderView.dart';

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
        Bind<ManagedProductsStoreInt>((i) => ManagedProductsStore()),
        Bind<OrderCollapsableTileStoreInt>((i) => OrderCollapsableTileStore(), singleton: false),
        Bind((i) => Product),
      ];

  @override
  List<Router> get routers => [
        Router(IOV_ALL_VIEW, child: (_, args) => ItemsOverviewAllView()),
        Router(IOV_FAV_VIEW,
            child: (_, args) => ItemsOverviewFavView(), transition: TransitionType.noTransition),
        Router(CART_VIEW, child: (_, args) => CartView()),
        Router(ORDERS_VIEW, child: (_, args) => OrderView()),
        Router(MANPRODUCTS_VIEW, child: (_, args) => ManagedProductsView()),
        Router(MANPRODUCTS_EDIT_VIEW, child: (_, args) => ManagedProductsEditionView()),
        Router(ITEM_DET_VIEW + ':id', child: (_, args) => ItemDetailView(args.params['id'])),
      ];

  @override
  Widget get bootstrap => AppDriver();
}
