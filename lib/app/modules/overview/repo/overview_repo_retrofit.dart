import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../core/properties/app_urls.dart';
import '../../inventory/entities/product.dart';
import 'i_overview_repo.dart';

part 'overview_repo_retrofit.g.dart';

//flutter pub run build_runner watch
@RestApi(baseUrl: URL_FIREBASE)
abstract class OverviewRepoRetrofit implements IOverviewRepo {

  factory OverviewRepoRetrofit(Dio dio, {String baseUrl}) = _OverviewRepoRetrofit;

  @override
  @GET(PRODUCTS_URL_RETROFIT)
  Future<List<Product>> getProducts();

  @override
  @PUT("$PRODUCTS_URL_RETROFIT/{id}")
  Future<int> updateProduct(@Body() Product product, [@Path() String id]);
}
