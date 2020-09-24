import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _predMockRepo;
  IOverviewRepo _customMockRepo;
  var _productFail;

  setUpAll(() {
    _productFail =
        Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));
  });

  setUp(() {
    _predMockRepo = PredefinedMockRepo();
    _customMockRepo = CustomMockRepo();
  });

  group('Overview | Repo | Sucessful', () {
    test('getProducts = Quantity', () {
      _predMockRepo.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('getProducts = Elements', () {
      _predMockRepo.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('updateProduct = 200', () {
      _predMockRepo
          .updateProduct(_productFail)
          .then((value) => expect(value, 200));
    });
  });

  group('Overview | Repo | Fail', () {
    test('getProducts = Empty List', () {
      when(_customMockRepo.getProducts()).thenAnswer((_) async => []);
      _customMockRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('updateProduct = 400', () {
      when(_customMockRepo.updateProduct(_productFail))
          .thenAnswer((_) async => 404);
      _customMockRepo
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('getProducts = null', () {
      when(_customMockRepo.getProducts()).thenAnswer((_) async => null);
      _customMockRepo.getProducts().then((value) => expect(value, isNull));
    });
  });
}
