import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Configurações",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft,
              color: Colors.black, size: 18),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: 300,
        child: Card( //card da listview de notificações ate seja um parceiro
          child: ListView(
            children: [
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.purple,
                  size: 25,
                ),
                title: const Text('Notificações'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.star,
                  color: Colors.red,
                  size: 25,
                ),
                title: const Text('Avalie nosso APP'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.green,
                  size: 25,
                ),
                title: const Text('Sobre o PetFinder'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.rocket,
                  color: Colors.orange,
                  size: 25,
                ),
                title: const Text('Seja um parceiro'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
