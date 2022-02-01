import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';

import '../../../../config/titles/overview_test_titles.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../core/bindings/overview_test_bindings.dart';

class OverviewRepoTests {
  void unit() {
    late IOverviewRepo _repo;
    late var _productFail;
    final _builder = Get.put(ProductDataBuilder());
    final _bindings = Get.put(OverviewTestBindings());
    final _titles = Get.put(OverviewTestTitles());
    final _productList = Get.put(MockedDatasource()).products();

    setUpAll(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _repo = Get.find<IOverviewRepo>();
      _productFail = _builder.ProductWithId();
    });

    test(_titles.repo_get_qtde_products, () {
      _repo.getProducts().then((value) {
        expect(value.length, _productList.length);
      });
    });

    test(_titles.repo_get_products, () {
      _repo.getProducts().then((value) {
        expect(value.elementAt(0).title, _productList.elementAt(0).title);
        expect(value.elementAt(3).description, _productList.elementAt(3).description);
      });
    });

    test(_titles.repo_update_product, () {
      _repo.updateProduct(_productFail).then((value) => expect(value, 200));
    });
  }
}