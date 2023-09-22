import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivePin extends StatefulWidget {
  const ActivePin({super.key});

  @override
  State<ActivePin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ActivePin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft,
              color: Colors.black, size: 18),
        ),
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
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Já possui um Pinn pet?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Escolha uma opção para continuar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 121, 119, 119),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              SizedBox(
                  height: 110,
                  width: 380,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    elevation: 1,
                    child: Center(
                      child: ListTile(
                        leading: const Icon(
                           Icons.qr_code,
                          color: Colors.grey,
                          size: 27,
                        ),
                        title: const Text(
                          'Ativar Pingente',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                            'Já tenho um pingente PINN PET e uero ativar o QR CODE'),
                        trailing:
                            const Icon(FontAwesomeIcons.angleRight, size: 20),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 110,
                  width: 380,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    elevation: 1,
                    child: Center(
                      child: ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.bagShopping,
                          color: Colors.grey,
                          size: 27,
                        ),
                        title: const Text(
                          'Quero um Pingente',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                            'instalei o aplicativo e quero solicitar um QR CODE para proteger meu pet.'),
                        trailing:
                            const Icon(FontAwesomeIcons.angleRight, size: 20),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
