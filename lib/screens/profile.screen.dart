import 'package:flutter/material.dart';

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
                backgroundImage: AssetImage('assets/seu_avatar.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Minha Conta'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Meu Endereço'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
