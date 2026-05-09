import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/authentication.input.decoration.dart';

class PetEdit extends StatefulWidget {
  final String petId;
  final Map<String, dynamic> petData;
  const PetEdit({super.key, required this.petId, required this.petData});

  @override
  State<PetEdit> createState() => _PetEditState();
}

class _PetEditState extends State<PetEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late String _gender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.petData['name']);
    _breedController = TextEditingController(text: widget.petData['breed']);
    _ageController = TextEditingController(text: widget.petData['age']);
    _gender = widget.petData['gender'] ?? "Macho";
  }

  Future<void> _updatePet() async {
    setState(() => _isLoading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('pets')
          .doc(widget.petId)
          .update({
        'name': _nameController.text,
        'breed': _breedController.text,
        'age': _ageController.text,
        'gender': _gender,
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pet atualizado!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao atualizar: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deletePet() async {
    bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Excluir Pet"),
            content: const Text("Tem certeza que deseja remover este pet?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancelar")),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text("Excluir", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirm) return;

    setState(() => _isLoading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('pets')
          .doc(widget.petId)
          .delete();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pet removido!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String petType = widget.petData['petType'] ?? 'Pet';
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar $petType"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: _isLoading ? null : _deletePet,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Avatar (Visual apenas por enquanto)
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.purple.shade50,
                child:
                    Icon(Icons.pets, size: 60, color: Colors.purple.shade200),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: getAuthenticationInputDecoration("Nome do Pet"),
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Informe o nome" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _breedController,
                decoration: getAuthenticationInputDecoration("Raça"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                decoration:
                    getAuthenticationInputDecoration("Idade / Data Nasc."),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Gênero",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildGenderButton("Macho", Icons.male)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGenderButton("Fêmea", Icons.female)),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) _updatePet();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("SALVAR ALTERAÇÕES",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label, IconData icon) {
    bool isSelected = _gender == label;
    return InkWell(
      onTap: () => setState(() => _gender = label),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isSelected ? Colors.purple : Colors.grey.shade300,
              width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
