import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_app_qrcode/screens/my_address.screen.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  double? latitude;
  double? longitude;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          // Parte inferior (caixa branca)
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
                  height: 16,
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
                      trailing:
                          const Icon(FontAwesomeIcons.angleRight, size: 20),
                      onTap: () {
                        getPosition();
                      },
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyAddress()));
                    },
                    child: const Text(
                      'Adicionar novo endereço',
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

  getPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    List<Placemark> locations =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (locations != null) {
      print(locations[0]);
    }
  }
}
