// Aqui ficara a pagina principal do app
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pet Finder",
          style: TextStyle(color: Colors.purple, fontSize: 40),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Icon(Icons.qr_code),
          ),
        ],
        leading: Image.asset("assets/logo_pet.png"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: 1000.0,
            height: 200.0,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.purple[600],
            width: 1000.0,
            height: 100.0,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.blue[600],
            width: 1000.0,
            height: 200.0,
          ),
        ],
      ),
    );
  }
}
