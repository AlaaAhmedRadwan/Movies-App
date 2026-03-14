import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyAvatar = 'user_avatar';
  static const _keyPhone = 'user_phone';
  static const _keyOnboardingSeen = 'onboarding_seen';

  static Future<void> saveAvatar(String assetPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAvatar, assetPath);
  }

  static Future<String?> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAvatar);
  }

  static Future<void> savePhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPhone, phone);
  }

  static Future<String?> loadPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhone);
  }

  static Future<void> saveOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingSeen, true);
  }

  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingSeen) ?? false;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAvatar);
    await prefs.remove(_keyPhone);
  }
}
