abstract class ISharedPrefsRepo {
  Future delete(String key);

  Future get(String key);

  Future put(String key, dynamic value);
}
