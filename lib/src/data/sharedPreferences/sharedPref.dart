import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  void saveData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String? data = prefs.getString(key);
      if (data != null) {
        return data;
      }
    } catch (_) {}
    return '';
  }
}
