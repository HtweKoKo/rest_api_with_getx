import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/controller/ThemeController.dart';
import 'package:rest_api/screen/bottomnav.dart';
import 'package:rest_api/service/api_service.dart';
import 'package:rest_api/models/postModel.dart';
import 'package:rest_api/utils/locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/deleteController.dart';
import 'controller/postController.dart';
import 'screen/home.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Get.put(ApiService(),);
  Get.put(PostController());
  Get.put(sharedPreferences);
  Get.put(ThemeController());
  

  runApp( GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      translations: ChangedLanguage(),
      locale:Locale("en","US"),
      fallbackLocale: Locale("en","MM"),

    home: BottomNav(),

  ));
}