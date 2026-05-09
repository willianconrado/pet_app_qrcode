import 'package:flutter/material.dart';

class VacinationPage extends StatelessWidget {
  const VacinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacinação"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Carteira de Vacinação",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Consulte as vacinas aplicadas e as próximas doses.",
            style: TextStyle(color: Colors.blueGrey),
          ),
          const SizedBox(height: 25),
          _buildVaccineItem("V10 / V8 (Polivalente)", "Aplicada em 10/04/2026", true),
          _buildVaccineItem("Antirrábica", "Aplicada em 10/04/2026", true),
          _buildVaccineItem("Gripe Canina", "Pendente - Prevista para Maio", false),
          _buildVaccineItem("Giardíase", "Pendente - Prevista para Maio", false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildVaccineItem(String name, String date, bool isApplied) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isApplied ? Colors.green.shade100 : Colors.orange.shade100,
          child: Icon(
            isApplied ? Icons.check : Icons.calendar_today,
            color: isApplied ? Colors.green : Colors.orange,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
