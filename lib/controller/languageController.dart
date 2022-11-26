
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rest_api/storage/storage.dart';

class LanguageController extends GetxController{
final Storage _storage = Get.find();
RxBool isMyanmar = false.obs;


  void _getTheme(){
        _storage.isChangeLanguage().then((value) {
          
          if(value){
            Get.updateLocale(Locale("en","Myanmar"));
          }

        });
  }
}