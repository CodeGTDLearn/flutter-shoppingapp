import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:test/test.dart';

import '../../../../config/overview_test_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import 'overview_mocked_repo.dart';

class OverviewRepoTests {
  static void unit() {
    IOverviewRepo _repo, _injectRepo;
    var _productFail;

    setUp(() {
      OverviewTestConfig().bindingsBuilder();
      _repo = Get.find<IOverviewRepo>();
      _injectRepo = OverviewInjectMockedRepo();
      _productFail = ProductDataBuilder().ProductId();
    });

    test('Checking Instances', () {
      expect(_repo, isA<IOverviewRepo>());
      expect(_productFail, isA<Product>());
      expect(_injectRepo, isA<OverviewInjectMockedRepo>());
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

    test('Getting products - Fail hence Empty', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => []);

      _injectRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Updating a Product - Response Status 404', () {
      when(_injectRepo.updateProduct(_productFail)).thenAnswer((_) async => 404);

      _injectRepo.updateProduct(_productFail).then((value) => {expect(value, 404)});
    });

    test('Getting products - Null as response', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => null);

      _injectRepo.getProducts().then((value) => expect(value, isNull));
    });
  }
}
