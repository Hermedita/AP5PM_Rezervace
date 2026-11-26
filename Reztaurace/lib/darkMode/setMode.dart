import 'package:shared_preferences/shared_preferences.dart';
bool isDarkMode = false;

Future<void> retrieveThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getBool("darkMode") != null){
    if(prefs.getBool("darkMode") == true){
      isDarkMode = true;
    }else{
      isDarkMode = false;
    }
  }
}