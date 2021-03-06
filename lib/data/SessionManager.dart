import 'package:shared_preferences/shared_preferences.dart';

class SessionManager
{
  static SharedPreferences sharedPreferences;

  static Future<Null> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KEY_ACCESS_TOKEN = 'asess_token';

  static String get accessToken => sharedPreferences.getString(KEY_ACCESS_TOKEN) ?? '';
  static set accessToken(String token) => sharedPreferences.setString(KEY_ACCESS_TOKEN, token);
}