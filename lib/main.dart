import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minisocial/auth/auth.dart';
import 'package:minisocial/auth/login_or_register.dart';
import 'package:minisocial/firebase_options.dart';
import 'package:minisocial/pages/home_page.dart';
import 'package:minisocial/pages/profile_page.dart';
import 'package:minisocial/pages/users_page.dart';
import 'package:minisocial/theme/dark_mode.dart';
import 'package:minisocial/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        "/login_register_page": (context) => const LoginOrRegister(),
        "/home_page": (context) =>  HomePage(),
        "/profile_page": (context) =>  ProfilePage(),
        "/users_page": (context) => const UsersPage(),
      },
    );
  }
}
