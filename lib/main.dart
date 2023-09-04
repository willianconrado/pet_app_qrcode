import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:pet_app_qrcode/screens/home.screen.dart';
import 'package:pet_app_qrcode/screens/notifications.screen.dart';
import 'package:pet_app_qrcode/screens/tabs.screen.dart';
import 'firebase_options.dart';
import 'screens/login.page.dart';
import 'screens/register.phone.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
