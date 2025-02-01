/* import 'package:hive/hive.dart';

Future<void> saveLoginStatus(String username) async {
  final box = Hive.box('settingsBox');
  await box.put('isLoggedIn', true);
  await box.put('username', username);
}

Future<bool> checkLoginStatus() async {
  final box = Hive.box('settingsBox');
  return box.get('isLoggedIn', defaultValue: false);
}

Future<String?> getUsername() async {
  final box = Hive.box('settingsBox');
  return box.get('username');
}

*/