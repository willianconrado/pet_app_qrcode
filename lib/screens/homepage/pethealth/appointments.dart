import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultas"), backgroundColor: Colors.purple, foregroundColor: Colors.white),
      body: const Center(child: Text("Página de Consultas")),
    );
  }
}
