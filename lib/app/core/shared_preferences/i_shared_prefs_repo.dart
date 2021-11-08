abstract class ISharedPrefsRepo {
  Future get(String key);

  void put(String key, dynamic value);
}
//  Future delete(String key);
