// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app_driver.dart';
import '../config/routes.dart';
import '../entities/product.dart';
import '../repositories/cartRepo.dart';
import '../repositories/cartRepoInt.dart';
import '../repositories/ordersRepo.dart';
import '../repositories/ordersRepoInt.dart';
import '../repositories/productsRepo.dart';
import '../repositories/productsRepoInt.dart';
import '../services/cartStore.dart';
import '../services/itemsOverviewGridProductItemStore.dart';
import '../services/itemsOverviewGridProductsStore.dart';
import '../services/managedProductsStore.dart';
import '../services/orderCollapsableTileStore.dart';
import '../services/ordersStore.dart';
import '../views/ItemsOverviewAllView.dart';
import '../views/cartView.dart';
import '../views/itemDetailView.dart';
import '../views/itemsOverviewFavView.dart';
import '../views/managedProductsEditionView.dart';
import '../views/managedProductsView.dart';
import '../views/orderView.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        //REPOSITORIES
        Bind<CartRepoInt>((i) => CartRepo()),
        Bind<ProductsRepoInt>((i) => ProductsRepo()),

        //SERVICE_STORES
        Bind<ItemsOverviewGridProductsStoreInt>(
            (i) => ItemsOverviewGridProductsStore()),
        Bind<ItemsOverviewGridProductItemStoreInt>(
            (i) => ItemsOverviewGridProductItemStore(),
            singleton: false),
        Bind<CartStoreInt>((i) => CartStore()),
        Bind<OrdersRepoInt>((i) => OrdersRepo()),
        Bind<OrdersStoreInt>((i) => OrdersStore()),
        Bind<ManagedProductsStoreInt>((i) => ManagedProductsStore()),
        Bind<OrderCollapsableTileStoreInt>((i) => OrderCollapsableTileStore(),
            singleton: false),
        Bind((i) => Product),
      ];

  @override
  List<Router> get routers => [
        Router(ITENSOVER_ALL_ROUTE, child: (_, args) => ItemsOverviewAllView()),
        Router(ITENSOVER_FAV_ROUTE,
            child: (_, args) => ItemsOverviewFavView(),
            transition: TransitionType.noTransition),
        Router(CART_ROUTE, child: (_, args) => CartView()),
        Router(ORDERS_ROUTE, child: (_, args) => OrderView()),
        Router(MANAGPRODUCT_ROUTE, child: (_, args) => ManagedProductsView()),
        Router(MANAGPRODUCT_ADD_ROUTE,
            child: (_, args) => ManagedProductsEditionView()),
        Router(MANAGPRODUCT_EDIT_ROUTE,
            child: (_, args) => ManagedProductsEditionView(args.params['id'])),
        Router(ITEMDETAILS_ROUTE + '/:id',
            child: (_, args) => ItemDetailView(args.params['id'])),
      ];

  @override
  Widget get bootstrap => AppDriver();
}
