import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';

import '../../../../data_builder/databuilder.dart';
import 'overview_repo_mocks.dart';

void main() {
  IOverviewRepo _mockRepo, _injectableRepoMock;
  var _productFail;

  setUpAll(() {
    _productFail = DataBuilder().ProductId();
  });

  setUp(() {
    _mockRepo = MockRepo();
    _injectableRepoMock = InjectableMockRepo();
  });

  group('Overview | Repo | Mocked-Repo', () {
    test('Checking Instances to be used in the Test', () {
      expect(_mockRepo, isA<MockRepo>());
    });

    test('Checking Response Type in GetProducts', () {
      _mockRepo.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting the quantity of products', () {
      _mockRepo.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('Getting products', () {
      _mockRepo.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('Updating a Product - Response Status 200', () {
      _mockRepo.updateProduct(_productFail).then((value) => expect(value, 200));
    });
  });
  group('Overview | Injectable-Mocked-Repo', () {
    test('Checking Instances to be used in the Test', () {
      expect(_injectableRepoMock, isA<InjectableMockRepo>());
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
