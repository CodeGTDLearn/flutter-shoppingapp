import '../entities/product.dart';

abstract class IManagedProductsRepo {
  List<Product> getAll();

  Product getById(String id);

  Future<void> add(Product product);

  bool update(Product product);

  void delete(String id);
}
