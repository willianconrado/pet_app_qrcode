import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_app_qrcode/_core/show.password.confirmation.dialog.dart';
import 'package:pet_app_qrcode/services/service.auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 300, //tamanho do card
              child: Card(
                //card da listview de notificações ate seja um parceiro
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
                      trailing:
                          const Icon(FontAwesomeIcons.angleRight, size: 20),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.star,
                        color: Colors.orange,
                        size: 25,
                      ),
                      title: const Text('Avalie nosso APP'),
                      trailing:
                          const Icon(FontAwesomeIcons.angleRight, size: 20),
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
                      trailing:
                          const Icon(FontAwesomeIcons.angleRight, size: 20),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.rocket,
                        color: Colors.red,
                        size: 25,
                      ),
                      title: const Text('Seja um parceiro'),
                      trailing:
                          const Icon(FontAwesomeIcons.angleRight, size: 20),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                  child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.gear,
                  color: Colors.grey,
                  size: 25,
                ),
                title: const Text('Termos de Uso'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                  child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.landmark,
                  color: Colors.grey,
                  size: 25,
                ),
                title: const Text('Política de Privacidade'),
                trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                onTap: () {},
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '3.5.2',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                AuthService().logOut().then((String? erro) {
                  if (erro == null) {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('SAIR DA MINHA CONTA',
                  style: TextStyle(color: Colors.orange, fontSize: 15)),
            ),
            TextButton(
              onPressed: () {
                showPasswordConfirmationDialog(context: context, email: "");
              },
              child: const Text('REMOVER CONTA',
                  style: TextStyle(color: Colors.red, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
