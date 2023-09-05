import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          width: 1000,
          height: 1000,
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
                child: Text(
                  "Meus endereços",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Assim você poderá enviar e receber alertas de animais perdidos em sua vizinhança!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 121, 119, 119),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 0,
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.grey,
                      size: 20,
                    ),
                    title: const Text('Pesquise seu endereço'),
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.locationCrosshairs,
                      color: Colors.grey,
                      size: 27,
                    ),
                    title: const Text('Usar Localização atual'),
                    subtitle: const Text('Ativar Localização'),
                    trailing: const Icon(FontAwesomeIcons.angleRight, size: 20),
                    onTap: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 35,
                width: 350,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Adicionar novo endereço',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
