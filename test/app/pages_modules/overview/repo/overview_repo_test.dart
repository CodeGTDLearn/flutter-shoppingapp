import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import '../../../../data_builder/databuilder.dart';
import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _dataMockRepo;
  IOverviewRepo _injectableRepoMock;
  var _productFail;

  setUpAll(() {
    _productFail = DataBuilder().ProductId();
  });

  setUp(() {
    _dataMockRepo = DataMockRepo();
    _injectableRepoMock = WhenMockRepo();
  });

  group('Overview | Repo | Mocked-Repo', () {
    test('Checking Instances to be tested: DataMockRepo', () {
      expect(_dataMockRepo, isA<DataMockRepo>());
    });

    test('Checking Response Type in GetProducts', () {
      _dataMockRepo.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting the quantity of products', () {
      _dataMockRepo.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('Getting products', () {
      _dataMockRepo.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('Updating a Product - Response Status 200', () {
      _dataMockRepo.updateProduct(_productFail).then((value) => expect(value, 200));
    });
  });

  group('Overview | Repo: WhenMock', () {
    test('Checking Instances to be tested: WhenMockRepo', () {
      expect(_injectableRepoMock, isA<WhenMockRepo>());
    });

    test('Getting products - Fail hence Empty', () {
      when(_injectableRepoMock.getProducts()).thenAnswer((_) async => []);

      _injectableRepoMock.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Updating a Product - Response Status 404', () {
      when(_injectableRepoMock.updateProduct(_productFail))
          .thenAnswer((_) async => 404);

      _injectableRepoMock
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('Getting products - Fail hence Null response', () {
      when(_injectableRepoMock.getProducts()).thenAnswer((_) async => null);

      _injectableRepoMock.getProducts().then((value) => expect(value, isNull));
    });
  });
}
