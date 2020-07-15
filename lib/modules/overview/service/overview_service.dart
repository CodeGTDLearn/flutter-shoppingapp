import 'package:get/get.dart';

import '../components/popup_appbar_enum.dart';
import '../product.dart';
import '../repo/i_overview_repo.dart';
import '../repo/overview_firebase_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo _repo = Get.put(OverviewFirebaseRepo());
//  final IOverviewRepo _repo = Get.find();

  @override
  List<Product> getProductsFiltering(Popup filter) {
    if (filter == Popup.Fav) {
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
