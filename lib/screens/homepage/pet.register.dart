import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetRegister extends StatefulWidget {
  const PetRegister({super.key});

  @override
  State<PetRegister> createState() => _PetRegisterState();
}

class _PetRegisterState extends State<PetRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft,
              color: Colors.black, size: 18),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Meu pet é um(a)...",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: CircleAvatar(
                    radius: 66,
                    backgroundImage: AssetImage("assets/dog.png"),
                  ),
                ),
                Text(
                  "Cachorro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: CircleAvatar(
                    radius: 66,
                    backgroundImage: AssetImage("assets/cat.png"),
                  ),
                ),
                Text(
                  "Gato",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: CircleAvatar(
                    radius: 66,
                    backgroundImage: AssetImage("assets/bird.png"),
                  ),
                ),
                Text(
                  "Pássaro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: CircleAvatar(
                    radius: 66,
                    backgroundImage: AssetImage("assets/pig.png"),
                  ),
                ),
                Text(
                  "Outro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
