import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';

import '../config/tests_properties.dart';
import '../config/titles/testdb_check_titles.dart';
import '../data_builders/order_databuilder.dart';
import '../data_builders/product_databuilder.dart';
import '../utils/testdb_utils.dart';
import '../utils/tests_global_utils.dart';

class MockedDatasourceLoader {
  final _dbUtils = Get.put(TestDbUtils());
  final _titles = Get.put(TestDbCheckTitles());
  final _globalUtils = Get.put(TestsGlobalUtils());
  late int sampleDbTotalItems;

  MockedDatasourceLoader(this.sampleDbTotalItems);

  void load({required bool start}) {
    setUpAll(() => _globalUtils.globalSetUpAll(
          testModuleName: '${_dbUtils.runtimeType.toString()}',
          label: 'Starting TestDb Checking: ',
        ));

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _dbUtils.runtimeType.toString(),
          label: 'TestDb Checking Finished: ',
        ));

    setUp(_globalUtils.globalSetUp);

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.check_db_status, (tester) async {
      await _dbUtils.isDbOnline(url: TESTDB_ROOT_URL, dbName: TESTDB_NAME);
    });

    testWidgets(_titles.clean_db_completelly, (tester) async {
      await _dbUtils.cleanDb(url: TESTDB_ROOT_URL, dbName: TESTDB_NAME);
    });

    testWidgets(_titles.load_db_products_sample_data, (tester) async {
      if (start) {
        var inputList = <Object>[];
        var outputList;
        var items = sampleDbTotalItems;

        for (var i = 0; i < items; i++) {
          inputList.add(ProductDataBuilder().ProductWithoutId_imageMap());
        }

        await _dbUtils
            .add_productList(collectionUrl: PRODUCTS_URL, objectList: inputList)
            .then((value) => outputList = value);

        expect(outputList.length, sampleDbTotalItems);
        expect(outputList[0], inputList[0]);
      }
    });

    testWidgets(_titles.load_db_orders_sample_data, (tester) async {
      var outputList;
      if (start) {
        await _dbUtils
            .add_multipleOrders(
                collectionUrl: ORDERS_URL,
                totalItems: sampleDbTotalItems,
                dataBuilder: OrderDatabuilder(second: DateTime.now().second).Order_full_withId)
            .then((value) => outputList = value);

        expect(outputList.length, sampleDbTotalItems);
      }
    });
  }
}