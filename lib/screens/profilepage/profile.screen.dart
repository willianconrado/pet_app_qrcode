
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app_qrcode/screens/profilepage/address.screen.dart';
import 'package:pet_app_qrcode/screens/profilepage/my.acc.dart';
import 'package:pet_app_qrcode/screens/settings.screen.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

   String? userProfileImageUrl;
  User? user;
  String? email;

   XFile? imageFile;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userProfileImageUrl = documentSnapshot.get('profileImageUrl');
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(
                top: 70), // Ajuste esta margem conforme necessário
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                     "Olá, ${user?.displayName ?? ''}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.purple,
                    size: 30,
                  ),
                  title: const Text('Minha Conta'),
                  trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyAcc(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: const Text('Meu Endereço'),
                    trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Address(),
                          ));
                    }),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.gear,
                    color: Colors.orange,
                    size: 30,
                  ),
                  title: const Text('Configurações'),
                  trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 59,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 55,
                    backgroundImage: userProfileImageUrl != null
                ? NetworkImage(userProfileImageUrl!) 
                : const AssetImage("assets/noprofilepicture.png") as ImageProvider,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
