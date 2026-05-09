import 'package:flutter/material.dart';
import '../screens/homepage/pethealth/appointments.dart';
import '../screens/homepage/pethealth/care.dart';
import '../screens/homepage/pethealth/medication.dart';
import '../screens/homepage/pethealth/vacination.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String text;
  final bool hasPets;

  const CategoryItem({
    super.key,
    required this.image,
    required this.text,
    this.hasPets = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          margin: const EdgeInsets.all(5),
          child: Material(
            elevation: 2,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {
                if (hasPets) {
                  Widget page;
                  switch (text) {
                    case "Cuidados":
                      page = const PetCarePage();
                      break;
                    case "Medicação":
                      page = const MedicationPage();
                      break;
                    case "Vacinação":
                      page = const VacinationPage();
                      break;
                    case "Consultas":
                      page = const AppointmentsPage();
                      break;
                    default:
                      page = const PetCarePage();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  );
                } else {
                  final snackBar = SnackBar(
                    content:
                        const Text("Você não possui nenhum pet cadastrado."),
                    backgroundColor: Colors.red[400],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
