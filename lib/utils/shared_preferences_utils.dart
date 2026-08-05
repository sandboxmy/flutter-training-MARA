import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static late SharedPreferences sharedPrefsUtils;

  Future<void> init() async {
    sharedPrefsUtils = await SharedPreferences.getInstance();
  }

  String get getToken => sharedPrefsUtils.getString('user_token') ?? '';

  String get getName => sharedPrefsUtils.getString('user_name') ?? '';

  String get getEmail => sharedPrefsUtils.getString('user_email') ?? '';

  Future<void> clearSharedPreferences() async {
    await sharedPrefsUtils.clear();
  }

  Future<void> setToken(String value) async {
    await sharedPrefsUtils.setString('user_token', value);
  }

  Future<void> setName(String value) async {
    await sharedPrefsUtils.setString('user_name', value);
  }

  Future<void> setEmail(String value) async {
    await sharedPrefsUtils.setString('user_email', value);
  }
}
