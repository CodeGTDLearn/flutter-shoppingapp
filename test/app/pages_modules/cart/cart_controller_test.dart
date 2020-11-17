import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/i_cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/pages_modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/orders_repo.dart';
import 'package:shopingapp/app/pages_modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/pages_modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../data_builders/cart_Item_databuilder.dart';
import '../../../data_builders/product_databuilder.dart';
import '../../../mocked_data_source/mocked_data_source.dart';

class CartControllerTest {
  static void integrationTests() {
    ICartController _controller;
    ICartService _service;
    ICartRepo _repo;
    IOrdersRepo _repoOrders;
    IOrdersService _serviceOrders;
    Product _product1, _product2;

    setUp(() {
      _product1 = ProductDataBuilder().ProductFull();
      _product2 = ProductDataBuilder().ProductFull();
      _repo = CartRepo();
      _service = CartService(repo: _repo);
      _repoOrders = OrdersRepo();
      _serviceOrders = OrdersService(repo: _repoOrders);
      _controller = CartController(
        cartService: _service,
        ordersService: _serviceOrders,
      );
    });

    // group(' Controller | Service | Repo', () {
      test('Checking Instances to be used in the Test', () {
        expect(_repo, isA<CartRepo>());
        expect(_service, isA<CartService>());
        expect(_controller, isA<CartController>());
        expect(_repoOrders, isA<OrdersRepo>());
        expect(_serviceOrders, isA<OrdersService>());
      });

      test('Getting ALL products from the Cart', () {
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);

        _controller.getAllCartItems().forEach((key, value) {
          expect(key.toString(), isIn(_controller.getAllCartItems()));
        });
        expect(_controller.getAllCartItems().length, 2);
        expect(_controller.getQtdeCartItemsObs(), 2);
      });

      test('Removing specific products from the Cart', () {
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);
        expect(_controller.getQtdeCartItemsObs(), 2);

        var listProductsInserted = _controller.getAllCartItems();
        expect(_product1.id.toString(), isIn(listProductsInserted));
        expect(_product2.id.toString(), isIn(listProductsInserted));

        //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
        var cartItem1 = CartItemDatabuilder.CartItemFromProduct(_product1);
        _controller.removeCartItem(cartItem1);
        expect(_controller.getAllCartItems().length, 1);
        expect(_controller.getQtdeCartItemsObs(), 1);
        expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

        //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
        var cartItem2 = CartItemDatabuilder.CartItemFromProduct(_product2);
        _controller.removeCartItem(cartItem2);
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.getAllCartItems().forEach((key, value) {
          if (key.toString() == cartItem1.id.toString()) {
            fail("Error: product 02 was found, but it must not be found");
          }
        });
      });

      test('Clearing ALL products from the Cart', () {
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);
        expect(_controller.getAllCartItems().length, 2);
        expect(_controller.getQtdeCartItemsObs(), 2);
        _controller.clearCart();
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
      });

      test('Adding two products in the Cart', () {
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);

        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);
        expect(_controller.getAllCartItems().length, 2);
        expect(_controller.getQtdeCartItemsObs(), 2);
        _controller.clearCart();

        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
      });

      test('Undo added product', () {
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);

        var listProductsInserted = _controller.getAllCartItems();
        expect(_product1.id.toString(), isIn(listProductsInserted));
        expect(_product2.id.toString(), isIn(listProductsInserted));

        _controller.addCartItemUndo(_product2);
        expect(_controller.getAllCartItems().length, 1);
        expect(_controller.getQtdeCartItemsObs(), 1);
        expect(_product1.id.toString(), isIn(listProductsInserted));
        expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));

        _controller.addCartItemUndo(_product1);
        expect(_controller.getAllCartItems().length, isZero);
        expect(_controller.getQtdeCartItemsObs(), isZero);
        expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
        expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));
      });

      test('Getting CartItems QuantityObs from the Cart', () {
        expect(_controller.getQtdeCartItemsObs(), isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);

        expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));
        expect(_product2.id.toString(), isIn(_controller.getAllCartItems()));
        expect(_controller.getQtdeCartItemsObs(), 2);
        _controller.clearCart();
        expect(_controller.getQtdeCartItemsObs(), isZero);
      });

      test('Getting CartItems AmountObs\$ from the Cart', () {
        expect(_controller.getAllCartItems().length, isZero);
        _controller.addCartItem(_product1);
        _controller.addCartItem(_product2);

        expect(_controller.getAllCartItems().length, 2);
        expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));
        expect(_product2.id.toString(), isIn(_controller.getAllCartItems()));

        expect(_controller.getAmountCartItemsObs(),
            _product1.price + _product2.price);
      });
    // });
  }
}
