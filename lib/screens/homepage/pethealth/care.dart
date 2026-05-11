import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/service.health.dart';
import '../../../services/health_event.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetCarePage extends StatefulWidget {
  const PetCarePage({super.key});

  @override
  State<PetCarePage> createState() => _PetCarePageState();
}

class _PetCarePageState extends State<PetCarePage> {
  final HealthService _healthService = HealthService();

  void _showAddCareDialog({String? prefillTitle}) {
    final titleController = TextEditingController(text: prefillTitle);
    final descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String? selectedPetId;
    String? selectedPetName;
    String? selectedPetImageUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Novo Cuidado",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Título (ex: Banho)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descrição (Opcional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              // Pet Selector
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('pets')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  var pets = snapshot.data!.docs;
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Selecionar Pet",
                      border: OutlineInputBorder(),
                    ),
                    items: pets.map((p) {
                      var data = p.data() as Map<String, dynamic>;
                      return DropdownMenuItem(
                        value: p.id,
                        child: Text(data['name'] ?? 'Sem nome'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      var petDoc = pets.firstWhere((p) => p.id == val);
                      var petData = petDoc.data() as Map<String, dynamic>;
                      setModalState(() {
                        selectedPetId = val;
                        selectedPetName = petData['name'];
                        selectedPetImageUrl = petData['imageUrl'];
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              ListTile(
                title: Text("Data: ${DateFormat('dd/MM/yyyy HH:mm').format(selectedDate)}"),
                trailing: const Icon(Icons.calendar_today, color: Colors.purple),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDate),
                    );
                    if (time != null) {
                      setModalState(() {
                        selectedDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty) {
                      await _healthService.addHealthEvent(
                        type: HealthEventType.care,
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: selectedDate,
                        petId: selectedPetId,
                        petName: selectedPetName,
                        petImageUrl: selectedPetImageUrl,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text("Salvar"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuidados"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "O que vamos fazer hoje?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildCareCard("Banho", Icons.bathtub, Colors.blue.shade100, Colors.blue),
                _buildCareCard("Tosa", Icons.content_cut, Colors.orange.shade100, Colors.orange),
                _buildCareCard("Passeio", Icons.directions_walk, Colors.green.shade100, Colors.green),
                _buildCareCard("Alimento", Icons.restaurant, Colors.red.shade100, Colors.red),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Últimos Registros",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<HealthEvent>>(
              stream: _healthService.getHealthEventsByType(HealthEventType.care),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final events = snapshot.data ?? [];
                if (events.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Nenhum cuidado registrado recentemente.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final e = events[index];
                    return _buildRecordItem(e);
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCareDialog(),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCareCard(String title, IconData icon, Color bgColor, Color iconColor) {
    return InkWell(
      onTap: () => _showAddCareDialog(prefillTitle: title),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iconColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordItem(HealthEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple.shade50,
            child: const Icon(Icons.check, color: Colors.purple, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (event.petName != null)
                  Text("Pet: ${event.petName}", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                Text(DateFormat('dd/MM/yyyy HH:mm').format(event.dateTime),
                    style: const TextStyle(color: Colors.purple, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
            onPressed: () => _healthService.deleteHealthEvent(event.id),
          ),
        ],
      ),
    );
  }
}
