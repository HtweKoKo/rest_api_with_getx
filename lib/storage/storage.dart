
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  SharedPreferences sharedPreferences = Get.find();
    final String theme = "theme";
    final String language = "language";

  Future<bool>   setTheme({required bool isDark})async{
   return    await sharedPreferences.setBool(theme, isDark);
  }
  Future<bool> isDarkTheme()async{
    return sharedPreferences.getBool(theme) ?? true;
  }
  Future<bool> setLanguage({required bool isMyanmar})async{
    return await sharedPreferences.setBool(language, isMyanmar);
  }
  Future<bool> isChangeLanguage()async{
return sharedPreferences.getBool(language) ?? true;
  }
}