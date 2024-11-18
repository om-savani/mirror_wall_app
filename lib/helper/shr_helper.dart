import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> setUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", url);
  }

  Future<String> getUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("url") ?? "https://www.google.com/";
  }
}
