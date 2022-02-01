import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/overview/components/overview_appbar/filter_options_enum.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../config/titles/overview_test_titles.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/overview_test_bindings.dart';

class OverviewControllerTests {
  void integration() {
    late IOverviewRepo _repo;
    late IOverviewService _service;
    late OverviewController _controller;
    final _titles = Get.put(OverviewTestTitles());
    final _bindings = Get.put(OverviewTestBindings());
    var _mockedDatasource = Get.put(MockedDatasource());
    var _product0, _product2, _product3;

    setUp(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _service = Get.find<IOverviewService>();
      _controller = Get.find<OverviewController>();
      _product0 = _mockedDatasource.products().elementAt(0);
      _product2 = _mockedDatasource.products().elementAt(2);
      _product3 = _mockedDatasource.products().elementAt(3);
    });

    test(_titles.controller_get_products, () {
      _controller.getProducts().then((value) {
        expect(value.elementAt(0).title, _product0.title);
        expect(value.elementAt(3).description, _product3.description);
      });
    });

    test(_titles.controller_update_filt_products, () {
      _controller.getProducts().then((value) {
        var productTest = _mockedDatasource.product();
        expect(_service.getLocalDataAllProducts().length, 4);
        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts().length, 5);

        _controller.updateFilteredProductsObs();
        expect(_controller.gridItemsObs.toList().length, 5);
      });
    });

    test(_titles.controller_delete_produts, () {
      _controller.getProducts().then((value) {
        expect(_service.getLocalDataAllProducts().length, 4);
        _controller.deleteProduct(_service.getLocalDataAllProducts().elementAt(0).id!);
        expect(_service.getLocalDataAllProducts().length, 3);
      });
    });

    test(_titles.controller_get_produts_qtde_favs, () {
      _controller.getProducts().then((value) {
        expect(_controller.getFavoritesQtde(), 1);
      });
    });

    test(_titles.controller_get_produts_qtde, () {
      _controller.getProducts().then((value) {
        expect(_controller.getProductsQtde(), 4);
      });
    });

    test(_titles.controller_get_produt_byid, () {
      var product = MockedDatasource().productById("p1");
      _controller.getProducts().then((value) {
        expect(
          _controller.getProductById(_product0.id).description,
          product.description,
        );
      });
    });

    test(_titles.controller_get_produts_by_filters, () {
      _controller.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(FilterOptionsEnum.All);
        _controller.applyPopupFilter(FilterOptionsEnum.All);
        expect(_controller.gridItemsObs.toList(), listAll);

        var listFav = _service.setProductsByFilter(FilterOptionsEnum.Fav);
        _controller.applyPopupFilter(FilterOptionsEnum.Fav);
        expect(_controller.gridItemsObs.toList(), listFav);
      });
    });

    test(_titles.controller_get_toggle_favs, () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product2.id).isFavorite, isTrue);

        _controller.toggleFavoriteStatus(_product2.id).then((sucessOperation) {
          expect(sucessOperation, isTrue);
          expect(_controller.getProductById(_product2.id).isFavorite, isFalse);
          expect(_controller.favoriteStatusObs.value, isFalse);
        });
      });
    });
  }
}