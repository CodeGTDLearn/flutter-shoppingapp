import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';

class OverviewMockRepoReturn extends Mock implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() async{
    final file = File('assets/mocks/products.json');
    final json = jsonDecode(await file.readAsString());
    var result = json.map<Product>((json)=> Product.fromJson(json)).toList();
    return result;
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(200);
  }
}
