import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';

import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _dataMockRepo;
  IOverviewRepo _whenMockRepo;
  var _productFail;

  setUpAll(() {
    _productFail =
        Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));
  });

  setUp(() {
    _dataMockRepo = DataMockRepo();
    _whenMockRepo = WhenMockRepo();
  });

  group('Overview | Repo: DataMock', () {
    test('checking Instantiations', () {
      expect(_dataMockRepo, isA<DataMockRepo>());
    });

    test('checking Response Type', () {
      _dataMockRepo.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('getProducts = Quantity', () {
      _dataMockRepo.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('getProducts = Elements', () {
      _dataMockRepo.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('updateProduct = 200', () {
      _dataMockRepo
          .updateProduct(_productFail)
          .then((value) => expect(value, 200));
    });
  });

  group('Overview | Repo: WhenMock', () {
    test('checking Instantiations', () {
      expect(_whenMockRepo, isA<WhenMockRepo>());
    });

    test('getProducts = Empty List', () {
      when(_whenMockRepo.getProducts()).thenAnswer((_) async => []);
      _whenMockRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('updateProduct = 400', () {
      when(_whenMockRepo.updateProduct(_productFail))
          .thenAnswer((_) async => 404);
      _whenMockRepo
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    // test('updateProduct = Exception + HttpResponse', () {
    //   when(_whenMockRepo.updateProduct(_productFail))
    //       .thenAnswer((_) async => http.Response('Not Found', 404));
    //
    //   expect(_whenMockRepo.updateProduct(_productFail), throwsException);
    // });

    test('getProducts = null', () {
      when(_whenMockRepo.getProducts()).thenAnswer((_) async => null);
      _whenMockRepo.getProducts().then((value) => expect(value, isNull));
    });
  });
}
