import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';

import '../../../config/data_builders/cartitem_databuilder.dart';
import '../../../config/datasource/mocked_datasource.dart';
import 'core/cart_test_bindings.dart';
import 'core/cart_test_titles.dart';

/*
 THERE IS NO NECESSITY OF _injectableRepoMock
 BECAUSE THERE IS NO 'CALLBACKS' FROM, WETHER DATABASE OR HTTP-CALLS
 (NAO EXISTE NECESSIDADE DE _injectableRepoMock
 POIS NAO EXISTEM 'CALLBACKS' DE DATABASE OU CHAMADAS-HTTP)
 */
class CartRepoTests {
  void unit() {
    late ICartRepo _repo;
    var _product0, _product1;
    final _titles = Get.find<CartTestTitles>();
    final _mock = Get.put(MockedDatasource());
    Get.create(() => CartTestBindings());

    setUpAll(() {
      // Get.create(() => CartTestBindings());
      Get.find<CartTestBindings>().bindingsBuilder(isWidgetTest: true);
      _repo = Get.find<ICartRepo>();
      _product0 = _mock.products().elementAt(0);
      _product1 = _mock.products().elementAt(1);
    });

    setUp(() {
      _repo.addCartItem(_product0);
      _repo.addCartItem(_product1);
    });

    test(_titles.repo_get_all_products, () {
      _repo.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_repo.getAllCartItems()));
      });
      expect(_repo.getAllCartItems().length, 2);
    });

    test(_titles.repo_remove_product, () {
      var listProductsInserted = _repo.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder().CartItemFromProduct(_product0);
      _repo.removeCartItem(cartItem1);
      expect(_repo.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder().CartItemFromProduct(_product1);
      _repo.removeCartItem(cartItem2);
      expect(_repo.getAllCartItems().length, isZero);
      _repo.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test(_titles.repo_clear_cart, () {
      expect(_repo.getAllCartItems().length, 2);
      _repo.clearCart();
      expect(_repo.getAllCartItems().length, isZero);
    });

    test(_titles.repo_add_two_products, () {
      expect(_repo.getAllCartItems().length, 2);
      _repo.clearCart();
      expect(_repo.getAllCartItems().length, isZero);
    });

    test(_titles.repo_undo_add_product, () {
      var listProductsInserted = _repo.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      _repo.addCartItemUndo(_product1);
      expect(_repo.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      _repo.addCartItemUndo(_product0);
      expect(_repo.getAllCartItems().length, isZero);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
    });
  }
}