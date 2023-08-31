import 'package:flutter/material.dart';

class RegisteScreen extends StatelessWidget {
  const RegisteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
       body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Container(
            width: 350,
            height: 600,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: TextButton(
              child: const Row(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                          width: 70,
                        ),
                        Text(
                          "tela de cadastro ainda não pronta",
                        ),
                      ],
                    ),
          onPressed: () {
           Navigator.pop(context);
          },
        ),
          ),
        ),
       )
    );
  }
}
