import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/overview_firebase_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../utils/mocked_data_source.dart';

void main() {
  IOverviewController _controller;

  setUp(() {
    final bindings = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
      Get.lazyPut<IOverviewService>(() => OverviewService());
      Get.lazyPut(() => OverviewController());
    });
    bindings.builder();
    _controller = Get.find<OverviewController>();
  });

  group('Overview | Controller: DataMock', () {
    test('Checking Instances', () {
      expect(_controller, isA<OverviewController>());
    });

    test('Checking Response Type', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('getFavoritesQtde', () {
      expect(_controller.getFavoritesQtde(), 1);
    });

    test('getProductById', () {
      var product = MockedDataSource().productById("p1");
      expect(_controller.getProductById("p1").description,
          product.description);
    });

    test('getProducts = Elements', () {
      _controller.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('getProductsQtde', () {
      expect(_controller.getProductsQtde(), 4);
    });

  });
}
