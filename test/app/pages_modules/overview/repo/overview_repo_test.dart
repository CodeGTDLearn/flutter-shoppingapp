import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/overview_firebase_repo.dart';
import 'package:test/test.dart';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import '../utils/mocked_data_source.dart';
import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _dataMockRepo;
  IOverviewRepo _mockRepo;
  var _productFail;

  setUpAll(() {
    _productFail =
        Product.databuilder(id: Faker().randomGenerator.string(3, min: 2));
  });

  setUp(() {
    _dataMockRepo = DataMockRepo();
    _mockRepo = MockRepo();
  });

  group('Overview | Repo', () {

    test('checking Instantiations', () {
      expect(_dataMockRepo, isA<DataMockRepo>());
      expect(_mockRepo, isA<MockRepo>());
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

    test('getProducts = Empty List', () {
      when(_mockRepo.getProducts()).thenAnswer((_) async => []);
      _mockRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('updateProduct = 400', () {
      when(_mockRepo.updateProduct(_productFail))
          .thenAnswer((_) async => 404);
      _mockRepo
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('getProducts = null', () {
      when(_mockRepo.getProducts()).thenAnswer((_) async => null);
      _mockRepo.getProducts().then((value) => expect(value, isNull));
    });
  });
}
