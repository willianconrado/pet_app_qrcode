import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app_qrcode/screens/homepage/pet.register.dart';
import 'package:pet_app_qrcode/screens/homepage/pet.edit.dart';
import 'package:pet_app_qrcode/screens/homepage/qrcode.page.dart';
import 'package:pet_app_qrcode/widgets/category-list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              "assets/logo_pet.png",
              width: 60,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              "Pet Finder",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 30,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodePage(),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('pets')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          final petCount = docs.length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/banner_home.png"),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                height: 200,
              ),
              const SizedBox(height: 8),
              const Text(
                "Serviços",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 8),
              CategoryList(hasPets: petCount > 0),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meus Pets ($petCount)",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: FloatingActionButton(
                        elevation: 1,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetRegister(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (petCount == 0) ...[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/pets.jpg"),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  height: 200,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Adicione um animalzinho.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  "Você ainda não possui nenhum pet cadastrado. \n Cadastre em sua conta!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ] else
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: petCount,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final pet = doc.data() as Map<String, dynamic>;
                      return _buildPetCard(context, pet, doc.id);
                    },
                  ),
                ),
              const SizedBox(height: 32),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/banner_indication.png"),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                height: 200,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPetCard(
      BuildContext context, Map<String, dynamic> pet, String petId) {
    String petType = pet['petType'] ?? 'Outro';
    String assetPath = "assets/dog.png";
    if (petType == "Gato") assetPath = "assets/cat.png";
    if (petType == "Pássaro") assetPath = "assets/bird.png";
    if (petType == "Outro") assetPath = "assets/pig.png";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetEdit(petId: petId, petData: pet),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16, bottom: 8, top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.purple.shade50,
              child: ClipOval(
                child: Builder(
                  builder: (context) {
                    // Try multiple possible field names for the image URL
                    final url = pet['imageUrl'] ?? pet['petPhotoUrl'] ?? pet['photoUrl'] ?? pet['image'];
                    if (url != null && url.toString().isNotEmpty) {
                      return Image.network(
                        url.toString(),
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(assetPath, fit: BoxFit.contain),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2));
                        },
                      );
                    }
                    return Image.asset(assetPath, fit: BoxFit.contain);
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              pet['name'] ?? 'Sem nome',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              pet['breed'] ?? 'SRD',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
