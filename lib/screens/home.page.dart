// Aqui ficara a pagina principal do app
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PetApp",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: Colors.black),
          child: const Icon(Icons.qr_code),
        ),
      ),
    );
  }
}
