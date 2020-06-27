import '../../overview/product.dart';

abstract class IManagedProductsService {
  List<Product> getAll();

  int managedProductsQtde();

  Product getById(String id);

  void add(Product product);

  void update(Product product);

  void delete(String id);
}
