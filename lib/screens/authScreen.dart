// ignore_for_file: use_build_context_synchronously, file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rescuesync/backend/client/fcm.dart';
import 'package:rescuesync/backend/client/auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:rescuesync/screens/homeScreen.dart';
import 'package:get_storage/get_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // Ekranı belirlemek için

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final Auth _auth = Auth();
  final FCMOnProcess fcmOnProcess = FCMOnProcess();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmToken;

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  getToken() async {
    fcmToken = await messaging.getToken();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isLogin ? 'Welcome Back!' : 'Create an Account',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (!isLogin)
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (isLogin) {
                      fcmToken = await messaging.getToken();
                      // Login işlemi
                      Future<dynamic> authentication = _auth.auth(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        action: 'login',
                        fcmToken: fcmToken,
                      );

                      authentication.then((result) async {
                        if (result == 'Login successful.') {
                          final box = GetStorage();
                          box.write('isLoggedIn', true);
                          box.write('username', _usernameController.text);

                          const snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Success!',
                              message: 'You have logged in successfully.',
                              contentType: ContentType.success,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const Homescreen()));
                        } else {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Login Failed!',
                              message: result,
                              contentType: ContentType.failure,
                            ),
                          );

                          print(result);

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      });
                    } else {
                      // Register işlemi
                      Future<dynamic> authentication = _auth.auth(
                        email: _emailController.text,
                        username: _usernameController.text,
                        password: _passwordController.text,
                        action: 'register',
                        fcmToken: fcmToken
                      );

                      // print(_emailController.text);
                      // print(fcmToken);
                      // print(_usernameController.text);
                      // print(_passwordController.text);

                      authentication.then((result) {
                        if (result == 'Registration successful.') {
                          final box = GetStorage();
                          box.write('isLoggedIn', true);
                          box.write('username', _usernameController.text);
                          const snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Success!',
                              message: 'Registration completed successfully.',
                              contentType: ContentType.success,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);

                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const Homescreen()));
                        } else {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Registration Failed!',
                              message: result,
                              contentType: ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03DAC5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 15), // Yükseklik
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size.fromHeight(50), // Minimum yükseklik
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width -
                        10, // Cihaz genişliği - kenar mesafesi
                    child: Center(
                      child: Text(
                        isLogin ? 'Login' : 'Register',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: toggleAuthMode,
                  child: Text(
                    isLogin
                        ? "Don't have an account? Register here"
                        : "Already have an account? Login here",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
