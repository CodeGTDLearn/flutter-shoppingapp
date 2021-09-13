import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';

import '../config/tests_properties.dart';
import '../config/titles/testdb_check_titles.dart';
import '../data_builders/product_databuilder.dart';
import '../utils/dbtest_utils.dart';
import '../utils/tests_global_utils.dart';

class PrepareDbTest {
  final _dbUtils = Get.put(DbTestUtils());
  final _titles = Get.put(TestDbCheckTitles());
  final _globalMethods = Get.put(TestsGlobalUtils());

  void executing() {
    setUpAll(() async => _globalMethods.globalSetUpAll(
          '${_dbUtils.runtimeType.toString()}',
          label: 'Starting TestDb Checking: ',
        ));

    tearDownAll(() => _globalMethods.globalTearDownAll(
          _dbUtils.runtimeType.toString(),
          label: 'TestDb Checking Finished: ',
        ));

    setUp(_globalMethods.globalSetUp);

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_online_status_db, (tester) async {
      await _dbUtils.isDbOnline(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
    });

    testWidgets(_titles.clean_db_completelly, (tester) async {
      await _dbUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
    });

    testWidgets(_titles.load_db_with_sample_data, (tester) async {
      var inputList = <Object>[];
      var outputList;
      var items = TOTAL_SAMPLEDATA_ITEMS_LOADED_IN_TESTDB;

      for (var i = 0; i < items; i++) {
        inputList.add(ProductDataBuilder().ProductWithoutId_imageMap());
      }

      await _dbUtils
          .add_objectList(collectionUrl: PRODUCTS_URL, objectList: inputList)
          .then((value) => outputList = value);

      expect(outputList.length, TOTAL_SAMPLEDATA_ITEMS_LOADED_IN_TESTDB);
      expect(outputList[0], inputList[0]);
      expect(outputList[1], inputList[1]);
    });
  }
}
