import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/cart_repo.dart';
import 'package:shopingapp/app/pages_modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';

/* **************************************************
  *--> TIPOS DE MOCK
  *    A) DATA MOCKS:
  *      DATA Mocks does NOT ALLOW
  *      the "WHEN"
  *     (because they has predefined responses)
  *
  *    B) "INJECTABLE" MOCKS:
  *      They are "Plain Mocks" (NO predefined responses);
  *      thus, they ALLOW the "WHEN"
  *
  *--> CONCEITO:
  *     Eles sao clones das Classes reais (replica de comportamento+retorno).
  *     Testes sao realizados em Mocks, NUNCA em classes reais
  *     FONTE: https://flutter.dev/docs/cookbook/testing/unit/mocking
  *
  *--> VISAO PRATICA:
  *     Mocks permitem:
  *     - Testes mais rapidos, do que os feitos em WebService ou DB
  *     - Testes independemente de WebServide ou DB
  *****************************************************/
// class CartMockRepo extends Mock implements ICartRepo {
//
//   ICartRepo _cartRepo = CartRepo();
//
//   @override
//   void addProductInTheCart(Product product) {
//     _cartRepo.addProductInTheCart(product);
//   }
//
//   @override
//   void clearCart() {
//     _cartRepo.clearCart();
//   }
//
//   @override
//   Map<String, CartItem> getAll() {
//     _cartRepo.getAll();
//   }
//
//   @override
//   void removeCartItem(CartItem cartItem) {
//     _cartRepo.removeCartItem(cartItem);
//   }
//
//   @override
//   void undoAddProductInTheCart(Product product) {
//     _cartRepo.undoAddProductInTheCart(product);
//   }
// }

class CartInjectableMockRepo extends Mock implements ICartRepo {}
