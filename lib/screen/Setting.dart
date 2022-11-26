import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rest_api/controller/ThemeController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      body: Column(
        children: [
          Obx(() {
            return Card(
              child: ListTile(
                leading: Text("Dark Theme"),
                trailing: Switch(
                    value: _themeController.isDark.value,
                  
                    onChanged: (value) {
                      print(value);
                      _themeController.setTheme(isDark: value);
                    }),
              ),
            );
          }),

          // Card(
          //   child: ListTile(
          //     leading: Text("language".tr),
          //     trailing: Switch(value:_checked2 ,
          //      onChanged: (value){
          //      setState(() {
          //         _checked2 = value;
          //      });
          //       if(_checked2){
          //         Get.updateLocale(Locale("en","MM"));
          //       }
          //       else{
          //         Get.updateLocale(Locale("en","US"));

          //       }
          //      }),
          //   ),
          // ),
        ],
      ),
    );
  }

  
}
