import '../product.dart';

abstract class IOverviewRepo {
  List<Product> getAll();

  List<Product> getFavorites();

  void toggleFavoriteStatus(String id);

  Product getById(String id);

  bool add(Product product);

  bool update(Product product);

  void delete(String id);
}
