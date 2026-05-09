import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_app_qrcode/screens/tabs.screen.dart';
import 'package:pet_app_qrcode/screens/verify_email_screen.dart';
import 'firebase_options.dart';
import 'screens/login.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.requestPermission();

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
      //home: const TabsPage(),
      home: const MapRouter(),
    );
  }
}

class MapRouter extends StatelessWidget {
  const MapRouter({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          User user = snapshot.data!;

          // Se o e-mail estiver verificado OU se for login via Google
          // (Login via Google já vem verificado por padrão)
          if (user.emailVerified ||
              user.providerData.any((p) => p.providerId == 'google.com')) {
            return const TabsPage();
          } else {
            // Se o e-mail não foi verificado ainda
            return const VerifyEmailScreen();
          }
        }

        return const LoginPage();
      },
    );
  }
}
