// import 'package:shared_preferences/shared_preferences.dart';

/* Future<void> loginUser(String username) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('username', username);
}


Future<void> removeUser() async {
  final prefs = await SharedPreferences.getInstance();
  
  await prefs.clear();
}

Future<String?> getUser() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('username');
}

Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();

  // isLoggedIn anahtarını kontrol et
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  return isLoggedIn ?? false; // Eğer değer yoksa varsayılan olarak false döner
}
*/