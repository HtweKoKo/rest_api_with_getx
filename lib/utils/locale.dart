import 'package:get/get.dart';

class ChangedLanguage extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US":{
        "home" : "Home",
        "upload" : "Upload",
        "setting" : "Setting",
        "language" : "မမသို့"
    },
    "en_MM":{
        "home" : "မူလစာမျက်နှာ",
        "upload" : "တင်တင်",
        "setting" : "ဆက်တင်",
        "language" : "Change to english language"
    }
  };


}