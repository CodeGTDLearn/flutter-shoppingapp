import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _optmisticList = [];

  @override
  Future<List<Product>> getAllManagedProducts() {
    var _rollbackList = _optmisticList;
    _optmisticList = [];

      //todo: Tirar o retorno List<Product> dete metodo, e repara todas as
    // ramificacaoes que dele dependem
    // Fazer esse metodo, simplesmente carregar a _optmisticList, e adaptar
    // nas ramificacoes que precisao deste metodo, uma abordagem que use
    // a _optmisticList instead of o retorno que aqui existia, que por sua
    // vez era List<Product>------ os metodos getAllManagedProducts so service
    // e do controller, deverao ser alimentados, e retornarao a _optmisticList
    // eles nao sera mais Futures, que retornam List<Product>. Assim a base
    // central do getAllManagedProducts serao , nao o retorno List<Product>
    // deste Future, mas sim a _optmisticList que alimentada por esse metodo
    // e seu verbo http, ela entao alimentara todo os sistema, portanto as
    //  renderizacoes da lista d eprosutos na tela centrla do 
    //  Managed_Products serao baseadas em getAllManagedProducts/_optmisticList

    // @formatter:off
    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
              json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {

            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap.toString();

            _optmisticList.add(productObjectCreatedFromDataMap);
            //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
      });
      return _optmisticList;
    }).catchError((onError){
      _optmisticList = _rollbackList;
    });
    // @formatter:on
  }

  @override
  List<Product> getAllManagedProductsOptmistic() {
    return _optmisticList;
  }

  @override
  int getManagedProductsQtde() {
    int productsQtde;
    getAllManagedProducts().then((value) {
      productsQtde = value.length;
    });
    return productsQtde;
  }

  @override
  Future<Product> getManagedProductById(String id) {
    // @formatter:off
    Product productObjectCreatedFromDataMap;

    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
          final MapDecodedFromJsonResponse =
          json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            if(idMap == id){
              productObjectCreatedFromDataMap = Product.fromJson(dataMap);
              productObjectCreatedFromDataMap.id = idMap;
            }
          });
          return productObjectCreatedFromDataMap;
        }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> saveManagedProduct(Product productSaved) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: productSaved.to_Json())
        .then((response) {
            productSaved.id = json.decode(response.body)['name'];
            _optmisticList.add(productSaved);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> updateManagedProduct(Product productUpdated) {
    // @formatter:off
    final _index =
    _optmisticList.indexWhere((item) => item.id == productUpdated.id);

    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productUpdated.id}.json", body:
            productUpdated.to_Json())
        .then((response) {
            if (_index >= 0)_optmisticList[_index] = productUpdated;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<int> deleteManagedProduct(String id) {
    final _index = _optmisticList.indexWhere((item) => item.id == id);
    var roolbackProduct = _optmisticList[_index];
    _optmisticList.removeAt(_index);
    // @formatter:off
    return http
        .delete("$BASE_URL/$COLLECTION_PRODUCTS/$id.json")
        .then((response)=> response.statusCode)
        .catchError((onError){
          _optmisticList.insert(_index, roolbackProduct);
          throw onError;
        });
    // @formatter:on
  }
}
