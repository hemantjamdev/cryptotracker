import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString("theme");
    return result;
  }

  static Future<bool> addFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favList = sharedPreferences.getStringList("favorites") ?? [];
    favList.add(id);
    return await sharedPreferences.setStringList("favorites", favList);
  }
  static Future<bool> removeFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favList = sharedPreferences.getStringList("favorites") ?? [];
    favList.remove(id);
    return await sharedPreferences.setStringList("favorites", favList);
  }
  static Future<List<String>>fetchFavorite()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favorites")??[];
  }
}
