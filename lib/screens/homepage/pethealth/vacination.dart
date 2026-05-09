import 'package:flutter/material.dart';

class VacinationPage extends StatelessWidget {
  const VacinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vacinação"), backgroundColor: Colors.purple, foregroundColor: Colors.white),
      body: const Center(child: Text("Página de Vacinação")),
    );
  }
}
