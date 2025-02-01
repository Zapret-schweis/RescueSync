import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rescuesync/backend/client/getStorage.dart';
import 'package:rescuesync/screens/authScreen.dart';

class Auth {
  Future<void> logout(BuildContext context) async {
    box.erase();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  Future<dynamic> auth({
  required String username,
  required String action,
  String? fcmToken,
  String? password,
  String? room,
  String? email,
}) async {
  var client = http.Client();

  try {
    Map<String, String> body = {
      'action': action,
      'username': username,
    };

    if (action == 'register' && email != null && password != null && fcmToken != null) {
      body['email'] = email;
      body['password'] = password;
      body['fcmToken'] = fcmToken;
    }

    if (action == 'login' && password != null && fcmToken != null) {
      body['password'] = password;
      body['fcmToken'] = fcmToken;
    }

    if (room != null) {
      body['room'] = room;
    }

    var response = await client.post(
      Uri.https('api.schweis.eu', '/rescuesync/process'),
      body: body,
    );

    var responseBody = utf8.decode(response.bodyBytes);
    // print('Response Body: $responseBody');
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(responseBody) as Map;
      if (decodedResponse['status'] == 'success') {
        return decodedResponse['data']; 
      } else {
        return decodedResponse['data'];
      }
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  } catch (e) {
    return 'Exception: $e';
  } finally {
    client.close();
  }
}
}



