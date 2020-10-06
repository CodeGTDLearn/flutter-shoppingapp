import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_bindings.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/overview_firebase_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../repo/overview_repo_mocks.dart';
import '../service/overview_service_mocks.dart';
import '../utils/mocked_data_source.dart';
import 'overview_controller_mocks.dart';

void main() {
  IOverviewController _dataMockController;

  setUp(() {
    _dataMockController = DataMockController();
  });

  group('Overview | Controller: DataMock', () {
    test('Checking Instances', () {
      expect(_dataMockController, isA<DataMockController>());
    });

    test('Checking Response Type', () {
      _dataMockController.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('getProducts = Elements', () {
      _dataMockController.getProducts().then((value) {
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('getFavoritesQtde', () {
      expect(_dataMockController.getFavoritesQtde(), 1);
    });

    test('getProductsQtde', () {
      expect(_dataMockController.getProductsQtde(), 4);
    });

    test('getProductById', () {
      var product = MockedDataSource().productById("p1");
      expect(_dataMockController.getProductById("p1").description,
          product.description);
    });
  });
}
