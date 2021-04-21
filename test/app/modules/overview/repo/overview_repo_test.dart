import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/repo/overview_repo_http.dart';
import 'package:test/test.dart';

import '../../../../test_utils/data_builders/product_databuilder.dart';
import '../../../../test_utils/test_utils.dart';
import '../overview_test_config.dart';
import 'overview_repo_mocks.dart';

class OverviewRepoTest {
  static void unit() {
    IOverviewRepo _repo, _injectRepo;
    var _productFail;

    setUp(() {
      _productFail = ProductDataBuilder().ProductId();
      OverviewTestConfig().testBinding.builder();
      _repo = Get.find<IOverviewRepo>();
      _injectRepo = OverviewInjectMockRepo();
      TestMethods.testInstanceName(Get.find<IOverviewRepo>());
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_repo, isA<IOverviewRepo>());
      expect(_productFail, isA<Product>());
    });

    test('Checking Response Type in GetProducts', () {
      _repo.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting the quantity of products', () {
      _repo.getProducts().then((value) {
        expect(value.length, 4);
      });
    });

    test('Getting products', () {
      _repo.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    //todo: erro authentication to be done
    test('Getting products - Error authentication', () {
      _repo.getProducts().catchError((onError) {
        if (onError.toString().isNotEmpty) {
          fail("Error: Aut");
        }
      });
    });

    test('Updating a Product - Response Status 200', () {
      _repo.updateProduct(_productFail).then((value) => expect(value, 200));
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_injectRepo, isA<OverviewInjectMockRepo>());
    });

    test('Getting products - Fail hence Empty', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => []);

      _injectRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Updating a Product - Response Status 404', () {
      when(_injectRepo.updateProduct(_productFail))
          .thenAnswer((_) async => 404);

      _injectRepo
          .updateProduct(_productFail)
          .then((value) => {expect(value, 404)});
    });

    test('Getting products - Null as response', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => null);

      _injectRepo.getProducts().then((value) => expect(value, isNull));
    });
  }
}
