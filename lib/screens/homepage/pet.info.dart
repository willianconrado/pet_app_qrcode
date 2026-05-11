import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/authentication.input.decoration.dart';

class PetInfo extends StatefulWidget {
  final String petType;
  const PetInfo({super.key, required this.petType});

  @override
  State<PetInfo> createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _gender = "Macho";
  bool _isLoading = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } finally {
      _isPickingImage = false;
    }
  }

  Future<String?> _uploadImage(String petId) async {
    if (_imageFile == null) return null;
    try {
      final user = FirebaseAuth.instance.currentUser;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(user!.uid)
          .child('pets')
          .child('$petId.jpg');
      
      final data = await _imageFile!.readAsBytes();
      await storageRef.putData(data);
      return await storageRef.getDownloadURL();
    } catch (e) {
      debugPrint("Erro no upload da imagem: $e");
      return "ERROR: $e";
    }
  }

  Future<void> _savePet() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuário não autenticado");

      // Generate a document reference first to get the ID for the image path
      final petRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('pets')
          .doc();

      String? imageUrl;
      if (_imageFile != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enviando imagem do pet...")),
          );
        }
        final result = await _uploadImage(petRef.id);
        if (result != null && result.startsWith("ERROR:")) {
          throw Exception("Falha no Firebase Storage: ${result.replaceFirst("ERROR: ", "")}");
        }
        imageUrl = result;
      }

      await petRef.set({
        'name': _nameController.text,
        'breed': _breedController.text,
        'age': _ageController.text,
        'gender': _gender,
        'petType': widget.petType,
        'imageUrl': imageUrl,
        'petPhotoUrl': imageUrl, // Redundant field for compatibility
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pet cadastrado com sucesso!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados do seu ${widget.petType}"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Avatar do Pet
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.purple.shade100, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey.shade100,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? Icon(
                              Icons.pets,
                              size: 60,
                              color: Colors.purple.shade200,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt,
                            size: 20, color: Colors.white),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Campo Nome
              TextFormField(
                controller: _nameController,
                decoration: getAuthenticationInputDecoration("Nome do Pet"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe o nome";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo Raça
              TextFormField(
                controller: _breedController,
                decoration: getAuthenticationInputDecoration("Raça"),
              ),
              const SizedBox(height: 20),
              // Campo Idade
              TextFormField(
                controller: _ageController,
                decoration:
                    getAuthenticationInputDecoration("Idade / Data Nasc."),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              // Seleção de Gênero
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gênero",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderButton("Macho", Icons.male),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGenderButton("Fêmea", Icons.female),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Botão Salvar
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _savePet();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    elevation: 4,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "CONCLUIR CADASTRO",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 20),
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
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
