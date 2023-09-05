import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_app_qrcode/screens/address.screen.dart';
import 'package:pet_app_qrcode/screens/settings.screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200, // Altura da foto de perfil
            color: Colors.purple, // Cor de fundo da parte superior
            child: const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.amber,
                // backgroundImage: AssetImage('assets/seu_avatar.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.user,
              color: Colors.purple,
              size: 30,
            ),
            title: const Text('Minha Conta'),
            trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
            onTap: () {},
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
    );
  }
}
