import 'package:maps_geogra/utils/state_manager.utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  Future<bool> isFirstLaunch(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  setFirstLaunch(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, value);
  }

  Future<bool> isAdmin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isAdmin") ?? false;
  }

  setUserRole(String role) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("isAdmin", role == Roles().ADMIN);
  }
}