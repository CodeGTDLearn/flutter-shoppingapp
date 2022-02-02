import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/properties/db_urls.dart';

import '../../app/core/test_titles/testdb_check_titles.dart';
import '../app_tests_properties.dart';
import '../data_builders/order_databuilder.dart';
import '../data_builders/product_databuilder.dart';
import '../utils/testdb_utils.dart';
import '../utils/tests_global_utils.dart';

class MockedDatasourceLoader {
  final _dbUtils = Get.put(TestDbUtils());
  final _titles = Get.put(TestDbCheckTitles());
  final _globalUtils = Get.put(TestsGlobalUtils());
  late int sampleDbTotalItems;
  var _outputList;

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
        // var outputList;
        var items = sampleDbTotalItems;

        for (var i = 0; i < items; i++) {
          inputList.add(ProductDataBuilder().ProductWithoutId_imageMap());
        }

        await _dbUtils
            .add_productList(collectionUrl: PRODUCTS_URL, objectList: inputList)
            .then((value) => _outputList = value);

        expect(_outputList.length, sampleDbTotalItems);
        expect(_outputList[0], inputList[0]);
      }
    });

    testWidgets(_titles.load_db_orders_sample_data, (tester) async {
      if (start) {
        await _dbUtils
            .add_multipleOrders(
                collectionUrl: ORDERS_URL,
                totalItems: sampleDbTotalItems,
                dataBuilder: () =>
                    OrderDatabuilder().OrderId_with_ProductList(_outputList))
            .then((value) {
          _outputList = value;
        });

        expect(_outputList.length, sampleDbTotalItems);
      }
    });
  }
}