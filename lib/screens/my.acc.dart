import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MyAcc extends StatefulWidget {
  const MyAcc({Key? key}) : super(key: key);

  @override
  State<MyAcc> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyAcc> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  void _takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
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
          child: const Icon(FontAwesomeIcons.chevronLeft,
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
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(FontAwesomeIcons.circleUser),
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                FontAwesomeIcons.phone,
                                size: 17,
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
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
      height: 100,
      width: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Escolher a foto de perfil",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  _takePhoto(ImageSource.camera);
                },
                label: const Text("Camera"),
              ),
              TextButton.icon(
                icon: const Icon(FontAwesomeIcons.images),
                onPressed: () {
                  _takePhoto(ImageSource.gallery);
                },
                label: const Text("Gallery"),
              ),
            ],
          )
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
              backgroundImage: imageFile == null
                ? const AssetImage("assets/noprofilepicture.png")
                : FileImage(File(imageFile!.path)) as ImageProvider,
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
