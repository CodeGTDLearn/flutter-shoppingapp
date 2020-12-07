import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';

import '../../../../data_builders/product_databuilder.dart';
import 'overview_repo_mocks.dart';

// void main() {
class OverviewRepoTest {
  static void unitTests() {
    IOverviewRepo _mockRepo, _injectMockRepo;
    var _productFail;

    setUpAll(() {
      _productFail = ProductDataBuilder().ProductId();
    });

    setUp(() {
      _mockRepo = OverviewMockRepo();
      _injectMockRepo = OverviewInjectMockRepo();
    });

    // group('Mocked-Repo', () {
    test('Checking Instances to be used in the Tests', () {
      expect(_mockRepo, isA<OverviewMockRepo>());
      expect(_productFail, isA<Product>());
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
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('Updating a Product - Response Status 200', () {
      _mockRepo.updateProduct(_productFail).then((value) => expect(value, 200));
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_injectMockRepo, isA<OverviewInjectMockRepo>());
    });

    test('Getting products - Fail hence Empty', () {
      when(_injectMockRepo.getProducts()).thenAnswer((_) async => []);

      _injectMockRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Updating a Product - Response Status 404', () {
      when(_injectMockRepo.updateProduct(_productFail))
          .thenAnswer((_) async => 404);

      _injectMockRepo
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('Getting products - Null as response', () {
      when(_injectMockRepo.getProducts()).thenAnswer((_) async => null);

      _injectMockRepo.getProducts().then((value) => expect(value, isNull));
    });
  }
}
