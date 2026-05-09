import 'package:flutter/material.dart';

class PetInfo extends StatefulWidget {
  final String petType;
  const PetInfo({super.key, required this.petType});

  @override
  State<PetInfo> createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações do ${widget.petType}"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          "Cadastro de ${widget.petType}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
