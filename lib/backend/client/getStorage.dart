// ignore_for_file: file_names

import 'package:get_storage/get_storage.dart';

final box = GetStorage();

// Kullanıcı oturumunu kaydetme
void saveUserSession(String username) {
  box.write('isLoggedIn', true);
  box.write('username', username);
}

// Kullanıcı oturumunu kontrol etme
bool isUserLoggedIn() {
  return box.read('isLoggedIn') ?? false;
}

// Kullanıcı adını alma
String? getUsername() {
  return box.read('username');
}