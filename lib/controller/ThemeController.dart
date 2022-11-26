import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/storage.dart';

class ThemeController extends GetxController {
  final Storage _storage = Get.put(Storage());
  RxBool isDark = false.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getTheme();
  }

  void setTheme({required bool isDark})async{
    await  _storage.setTheme(isDark: isDark);
    _getTheme();
  }

  void _getTheme() {
    _storage.isDarkTheme().then((value) {
      if (value) {
        Get.changeThemeMode(ThemeMode.dark);
        isDark.value = true;
      } else {
        Get.changeThemeMode(ThemeMode.light);
        isDark.value = false;
      }
    });
  }
}
