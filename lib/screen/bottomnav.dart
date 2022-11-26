import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rest_api/screen/Setting.dart';
import 'package:rest_api/screen/Upload.dart';
import 'package:rest_api/screen/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
    Widget _body = Home();
  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
          body: _body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "home".tr),
            BottomNavigationBarItem(icon: Icon(Icons.add),label: "upload".tr),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "setting".tr),
          ],
          onTap: ((int value) {
            setState(() {
              _currentIndex = value;
              if(_currentIndex == 0){
                _body = Home();
              }
              else if(_currentIndex == 1){
                _body = Upload();
              }
              else{
                _body = Setting();
              }
            });
          }),
          
          ),


    );
  }
}