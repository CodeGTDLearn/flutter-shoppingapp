import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/pages_modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/pages_modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/pages_modules/orders/service/orders_service.dart';
import 'package:test/test.dart';

import '../../../test_utils/data_builders/cartitem_databuilder.dart';
import '../../../test_utils/data_builders/product_databuilder.dart';
import '../../../test_utils/mocked_data/mocked_orders_data.dart';
import '../orders/repo/orders_repo_mocks.dart';

class CartControllerTest {
  static void integration() {
    CartController _controller;
    ICartService _cartService;
    ICartRepo _repo;
    IOrdersRepo _repoMockOrders;
    IOrdersService _ordersService;
    Product _product1, _product2;
    Order _order1;
    var _cartItems = CartItemDatabuilder.cartItems();

    setUp(() {
      _product1 = ProductDataBuilder().ProductFull();
      _product2 = ProductDataBuilder().ProductFull();
      _order1 = OrdersMockedData().orders().elementAt(0);

      _repo = CartRepo();
      _cartService = CartService(repo: _repo);

      _repoMockOrders = OrdersMockRepo();
      _ordersService = OrdersService(repo: _repoMockOrders);

      _controller = CartController(
        cartService: _cartService,
        ordersService: _ordersService,
      );
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_repo, isA<CartRepo>());
      expect(_cartService, isA<CartService>());
      expect(_controller, isA<CartController>());
      expect(_repoMockOrders, isA<OrdersMockRepo>());
      expect(_ordersService, isA<OrdersService>());
      expect(_cartItems, isA<List<CartItem>>());
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

    test('Adding Orders', () {
      _controller
          .addOrder(_order1.cartItems, double.parse(_order1.amount))
          .then((orderReturned) {
        expect(orderReturned.id, _order1.id);
        expect(orderReturned.cartItems[0].id, _order1.cartItems[0].id);
        expect(orderReturned.cartItems[1].id, _order1.cartItems[1].id);
      });
    });
  }
}
