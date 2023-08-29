import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/screens/address.dart';
import 'package:pet_app_qrcode/screens/login.page.dart';
import 'screens/register.phone.dart';

void main() {
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
      home: const Address(),
    );
  }
}
