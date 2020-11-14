import 'package:shopingapp/app/pages_modules/cart/repo/cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:test/test.dart';

import '../../../../data_builders/cart_Item_databuilder.dart';
import '../../../../data_builders/product_databuilder.dart';
import 'cart_repo_mocks.dart';

class CartRepoTest {
  static void unitTests() {
    ICartRepo _repo, _injectableRepoMock;
    Product _product1, _product2;

    setUp(() {
      _product1 = ProductDataBuilder().ProductFull();
      _product2 = ProductDataBuilder().ProductFull();
      _repo = CartRepo();
      _injectableRepoMock = CartInjectableMockRepo();
    });

    group('Repo', () {
      test('Checking Instances to be used in the Test', () {
        expect(_repo, isA<CartRepo>());
        expect(_product1, isA<Product>());
        expect(_product2, isA<Product>());
      });

      test('Getting ALL products from the Cart', () {
        expect(_repo.getAll().length, isZero);
        _repo.addProductInTheCart(_product1);
        _repo.addProductInTheCart(_product2);

        _repo.getAll().forEach((key, value) {
          expect(key.toString(), isIn(_repo.getAll()));
        });
        expect(_repo.getAll().length, 2);
      });

      test('Removing specific products from the Cart', () {
        expect(_repo.getAll().length, isZero);
        _repo.addProductInTheCart(_product1);
        _repo.addProductInTheCart(_product2);

        _repo.getAll().forEach((key, value) {
          expect(key.toString(), isIn(_repo.getAll()));
        });

        //todo: refactoring removings to inseide forEach
        // _repo.getAll().forEach((key, value) {
        // var cartItem = CartItemDatabuilder.CartItemFromProduct(value);
        //
        // });

        var cartItem = CartItemDatabuilder.CartItemFromProduct(_product1);
        _repo.removeCartItem(cartItem);
        expect(_repo.getAll().length, 1);

        _repo.getAll().forEach((key, value) {
          if(key.toString() ==  cartItem.id.toString())
            fail("Error: product 01 was found");
        });

        cartItem = CartItemDatabuilder.CartItemFromProduct(_product2);
        _repo.removeCartItem(cartItem);
        expect(_repo.getAll().length, isZero);

        _repo.getAll().forEach((key, value) {
          if(key.toString() ==  cartItem.id.toString())
            fail("Error: product 02 was found");
        });
      });

      test('Clearing ALL products from the Cart', () {
        expect(_repo.getAll().length, isZero);
        _repo.addProductInTheCart(_product1);
        _repo.addProductInTheCart(_product2);
        expect(_repo.getAll().length, 2);
        _repo.clearCart();
        expect(_repo.getAll().length, isZero);
      });

      test('Adding two products in the Cart', () {
        expect(_repo.getAll().length, isZero);
        _repo.addProductInTheCart(_product1);
        _repo.addProductInTheCart(_product2);
        expect(_repo.getAll().length, 2);
        _repo.clearCart();
        expect(_repo.getAll().length, isZero);
      });
    });

    group('Injectable-Mocked-Repo', () {
      test('Checking Instances to be used in the Test', () {
        expect(_injectableRepoMock, isA<CartInjectableMockRepo>());
      });
    });
  }
}
