import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _repoMock;
  IOverviewRepo _repoMockWhen;
  var _productFail;

  setUpAll(() {
    _productFail =
        Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));
  });

  setUp(() {
    _repoMock = DataMockRepo();
    _repoMockWhen = WhenMockRepo();
  });

  group('Overview | Repo: DataMock', () {
    test('checking Instantiations', () {
      expect(_repoMock, isA<DataMockRepo>());
    });

    test('checking Response Type', () {
      _repoMock.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('getProducts = Quantity', () {
      _repoMock.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('getProducts = Elements', () {
      _repoMock.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('updateProduct = 200', () {
      _repoMock
          .updateProduct(_productFail)
          .then((value) => expect(value, 200));
    });
  });

  group('Overview | Repo: WhenMock', () {
    test('checking Instantiations', () {
      expect(_repoMockWhen, isA<WhenMockRepo>());
    });

    test('getProducts = Empty List', () {
      when(_repoMockWhen.getProducts()).thenAnswer((_) async => []);

      _repoMockWhen.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('updateProduct = 400', () {
      when(_repoMockWhen.updateProduct(_productFail))
          .thenAnswer((_) async => 404);

      _repoMockWhen
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('getProducts = null', () {
      when(_repoMockWhen.getProducts()).thenAnswer((_) async => null);

      _repoMockWhen.getProducts().then((value) => expect(value, isNull));
    });
  });
}
