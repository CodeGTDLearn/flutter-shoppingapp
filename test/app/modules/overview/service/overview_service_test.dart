import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/overview/components/overview_appbar/filter_options_enum.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../../config/titles/overview_test_titles.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../core/bindings/overview_test_bindings.dart';

class OverviewServiceTests {
  void unit() {
    late IOverviewService _service;
    final _titles = Get.put(OverviewTestTitles());
    final _bindings = Get.put(OverviewTestBindings());
    final _productList = Get.put(MockedDatasource()).products();
    var _product0;
    var _product2;
    var _product3;

    setUpAll(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _service = Get.find<IOverviewService>();
      _product0 = _productList.elementAt(0);
      _product2 = _productList.elementAt(2);
      _product3 = _productList.elementAt(3);
    });

    test(_titles.service_get_localdata, () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataAllProducts();
        expect(list.elementAt(0).title, _product0.title);
        expect(list.elementAt(3).description, _product3.description);
      });
    });

    test(_titles.service_get_localdata_favs, () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataFavoritesProducts();
        expect(list.elementAt(0).isFavorite, isTrue);
        expect(list.elementAt(0).title, _product2.title);
        expect(list.elementAt(0).price, _product2.price);
      });
    });

    test(_titles.service_add_product_localdata, () {
      var productTest = MockedDatasource().product();

      _service.getProducts().then((_) {
        expect(_service.getLocalDataAllProducts().length, 4);

        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts().length, 5);
        expect(_service.getLocalDataAllProducts().elementAt(4).title, productTest.title);
      });
    });

    test(_titles.service_delete_product_localdata, () {
      _service.getProducts().then((value) {
        expect(_service.getLocalDataAllProducts().length, 4);
        _service.deleteProductInLocalDataLists(
            _service.getLocalDataAllProducts().elementAt(0).id!);
        expect(_service.getLocalDataAllProducts().length, 3);
      });
    });

    test(_titles.service_get_products, () {
      _service.getProducts().then((FetchedList) {
        expect(FetchedList.elementAt(0).title, _product0.title);
        expect(FetchedList.elementAt(3).description, _product3.description);
      });
    });

    test(_titles.service_get_product_exc, () {
      _service.getProducts().then((_) {
        expect(() {
          var fakeId = Faker().randomGenerator.string(3, min: 2);
          return _service.getProductById(fakeId);
        }, throwsA(const TypeMatcher<RangeError>()));
      });
    });

    test(_titles.service_toggle_fav_status, () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product2.id!).isFavorite, isTrue);

        _service.toggleFavoriteStatus(_product2.id!).then((toggleReturn) {
          expect(toggleReturn, isFalse);
          expect(_service.getProductById(_product2.id!).isFavorite, isFalse);
        });
      });
    });

    test(_titles.service_get_qtde_favs, () {
      _service.getProducts().then((_) {
        expect(_service.getFavoritesQtde(), 1);
      });
    });

    test(_titles.service_get_product_byid, () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataAllProducts;
        expect(_service.getProductById(_product0.id!).description,
            list().elementAt(0).description);
      });
    });

    test(_titles.service_get_products_qtde, () {
      _service.getProducts().then((_) {
        expect(_service.getProductsQtde(), 4);
      });
    });

    test(_titles.service_get_products_by_filter, () {
      _service.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(FilterOptionsEnum.All);
        var listFav = _service.setProductsByFilter(FilterOptionsEnum.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
      });
    });

    test(_titles.service_clear_products_localdata, () {
      _service.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(FilterOptionsEnum.All);
        var listFav = _service.setProductsByFilter(FilterOptionsEnum.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
        _service.clearDataSavingLists();
        listAll = _service.setProductsByFilter(FilterOptionsEnum.All);
        listFav = _service.setProductsByFilter(FilterOptionsEnum.Fav);
        expect(listAll.length, 0);
        expect(listFav.length, 0);
      });
    });
  }
}