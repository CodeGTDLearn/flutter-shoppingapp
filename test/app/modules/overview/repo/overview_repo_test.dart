import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';

import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../data_builders/product_databuilder.dart';
import 'overview_mocked_repo_inject.dart';

class OverviewRepoTests {
  static void unit() {
    late IOverviewRepo _repo, _injectRepo;
    late var _productFail;
    var testConfig = Get.put(OverviewTestBindings());

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true);
      _repo = Get.find<IOverviewRepo>();
      _injectRepo = OverviewMockedRepoInject();
      _productFail = ProductDataBuilder().ProductWithId();
    });

    test('Checking Instances', () {
      expect(_repo, isA<IOverviewRepo>());
      expect(_productFail, isA<Product>());
      expect(_injectRepo, isA<OverviewMockedRepoInject>());
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
  }
}
