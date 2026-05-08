import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAcc extends StatefulWidget {
  final ImageProvider? profileImage;

  const MyAcc({Key? key, this.profileImage}) : super(key: key);

  @override
  State<MyAcc> createState() => _MyWidgetState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class _MyWidgetState extends State<MyAcc> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? userProfileImageUrl;

  Future<String> uploadImageToStorage(String userId, XFile imageFile) async {
    final Reference ref = storage.ref().child('profile_images').child(userId);
    final UploadTask uploadTask = ref.putFile(File(imageFile.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateUserProfileImage(String userId, String imageUrl) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users.doc(userId).set({
      'profileImageUrl': imageUrl,
    }, SetOptions(merge: true));
  }

  User? user;
  String? email;
  XFile? _image;
  bool _isSaving = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // Realize o upload da imagem para o Firebase Storage
      final downloadUrl = await uploadImageToStorage(user!.uid, image);

      // Atualize a URL da imagem de perfil no Firestore
      await updateUserProfileImage(user!.uid, downloadUrl);

      if (mounted) {
        setState(() {
          _image = XFile(image.path);
          userProfileImageUrl = downloadUrl; // AGORA A TELA ATUALIZA NA HORA!
        });
      }
    } catch (e) {
      print("Erro ao trocar foto: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    email = user?.email;
    _nameController.text = user?.displayName ?? '';

    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists && mounted) {
          final data = documentSnapshot.data() as Map<String, dynamic>?;
          final photoUrl = data?['profileImageUrl'];
          if (photoUrl != null && photoUrl != '') {
            setState(() {
              userProfileImageUrl = photoUrl;
            });
          }
          // Carrega nome e telefone salvos no Firestore
          if (data?['name'] != null) {
            _nameController.text = data!['name'];
          }
          if (data?['phone'] != null) {
            _phoneController.text = data!['phone'];
          }
        }
      }).catchError((e) => print("Erro ao buscar: $e"));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (user == null) return;
    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': email,
      }, SetOptions(merge: true));

      // Atualiza o displayName no Firebase Auth também
      await user!.updateDisplayName(_nameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Minha Conta",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const FaIcon(FontAwesomeIcons.chevronLeft,
              color: Colors.black, size: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            imageProfile(context),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 600, //tamanho do card
              child: Card(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Validar telefone",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome Completo',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const FaIcon(FontAwesomeIcons.circleUser),
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Número de Telefone',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const FaIcon(
                                FontAwesomeIcons.phone,
                                size: 17,
                              ),
                              hintText: '(11) 99999-9999',
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon:
                                  const FaIcon(FontAwesomeIcons.envelope),
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: InputBorder.none,
                            ),
                            initialValue: email ?? '',
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : () => _saveProfile(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 39),
                          ),
                          child: _isSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Salvar",
                                  style: TextStyle(fontSize: 17),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta o tamanho ao conteúdo
        children: <Widget>[
          const Text(
            "Escolher foto de perfil",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.camera_alt, color: Colors.purple),
                    onPressed: () {
                      _takePhoto(ImageSource.camera);
                      Navigator.pop(context); // Fecha o modal após clicar
                    },
                  ),
                  const Text("Câmera")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.image, color: Colors.purple),
                    onPressed: () {
                      _takePhoto(ImageSource.gallery);
                      Navigator.pop(context); // Fecha o modal após clicar
                    },
                  ),
                  const Text("Galeria")
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget imageProfile(context) {
    return Stack(
      children: <Widget>[
        Center(
          child: CircleAvatar(
            radius: 63,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 59,
              backgroundImage: userProfileImageUrl != null
                  ? NetworkImage(userProfileImageUrl!)
                  : const AssetImage("assets/noprofilepicture.png")
                      as ImageProvider,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
            ),
          ),
        ),
      ],
    );
  }
}
