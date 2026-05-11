import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/service.health.dart';
import '../../../services/health_event.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final HealthService _healthService = HealthService();

  void _showAddAppointmentDialog() {
    final titleController = TextEditingController();
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
                "Nova Consulta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Título (ex: Check-up Geral)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descrição (Clínica, Veterinário...)",
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
                    firstDate: DateTime.now(),
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
                        type: HealthEventType.appointment,
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
                  child: const Text("Agendar"),
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
        title: const Text("Consultas"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder<List<HealthEvent>>(
        stream: _healthService.getHealthEventsByType(HealthEventType.appointment),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data ?? [];
          final nextEvent = events.isNotEmpty ? events.first : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Agendamentos",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),
                // Próxima Consulta Highlight
                if (nextEvent != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "PRÓXIMA CONSULTA",
                              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nextEvent.title,
                                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${DateFormat('dd de MMMM', 'pt_BR').format(nextEvent.dateTime)} • ${DateFormat('HH:mm').format(nextEvent.dateTime)}h",
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  if (nextEvent.petName != null)
                                    Text(
                                      "Pet: ${nextEvent.petName}",
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                                ],
                              ),
                            ),
                            if (nextEvent.petImageUrl != null && nextEvent.petImageUrl!.isNotEmpty)
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white24,
                                backgroundImage: NetworkImage(nextEvent.petImageUrl!),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  const Text("Nenhuma consulta agendada."),
                
                const SizedBox(height: 30),
                const Text(
                  "Histórico de Visitas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                if (events.isEmpty)
                  const Text("Sem histórico disponível.")
                else
                  ...events.map((e) => _buildAppointmentItem(e)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAppointmentDialog,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppointmentItem(HealthEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple.shade50,
            child: const Icon(Icons.location_on, color: Colors.purple),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(event.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                if (event.petName != null)
                  Text("Pet: ${event.petName}", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                const SizedBox(height: 4),
                Text(DateFormat('dd/MM/yyyy HH:mm').format(event.dateTime), 
                    style: const TextStyle(color: Colors.purple, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            onPressed: () => _healthService.deleteHealthEvent(event.id),
          ),
        ],
      ),
    );
  }
}
