import 'package:flutter_modular/flutter_modular.dart';

import '../components/popup_appbar_enum.dart';
import '../product.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final _repo = Modular.get<IOverviewRepo>();

  @override
  List<Product> getProductsFiltering(PopupEnum filter) {
    if (filter == PopupEnum.Favorites) {
      return _repo.getFavorites().length != 0 ? _repo.getFavorites() : [];
    }
    return _repo.getAll().length != 0 ? _repo.getAll() : [];
  }

  @override
  int qtdeFavorites() {
    return _repo.getFavorites().length;
  }

  @override
  int qtdeProducts() {
    return _repo.getAll().length;
  }
}
