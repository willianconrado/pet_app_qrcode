import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:pet_app_qrcode/screens/home.page.dart';
import 'package:pet_app_qrcode/screens/notifications.page.dart';
import 'package:pet_app_qrcode/screens/tabs.page.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const TabsPage(),
    );
  }
}
