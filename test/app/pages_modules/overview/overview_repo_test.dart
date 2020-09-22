import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';

import 'mocks/mock_repo_return.dart';
import 'mocks/mock_repo_when.dart';

void main() {
  IOverviewRepo _repoMockSucess;
  IOverviewRepo _repoMockFail;

  setUp(() {
    _repoMockSucess = OverviewMockRepoReturn();
    _repoMockFail = OverviewMockRepoWhen();
  });

  group('Module: Overview | Class: OverviewRepo | Return/Sucess', () {
    test('updateProduct = 200', () {
      var _product =
          Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));
      _repoMockSucess
          .updateProduct(_product)
          .then((value) => expect(value, 200));
    });

    test('getProducts = Quantity', () {
      _repoMockSucess.getProducts().then((value) => expect(value.length, 4));
    });

    test('getProducts = Elements', () {
      _repoMockSucess.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });
  });

  group('Module: Overview | Class: OverviewRepo | When/Fail', () {
    var _productFail =
        Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));

    test('updateProduct = 400', () {
      when(_repoMockFail.updateProduct(_productFail))
          .thenAnswer((_) async => 404);

      _repoMockFail
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('getProducts = null', () {
      when(_repoMockFail.getProducts()).thenAnswer((_) async => null);
      _repoMockFail.getProducts().then((value) => expect(value, isNull));
    });

    test('getProducts = Empty List', () {
      when(_repoMockFail.getProducts()).thenAnswer((_) async => []);
      _repoMockFail.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });
  });
}
