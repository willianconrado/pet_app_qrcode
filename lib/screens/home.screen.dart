// Aqui ficara a pagina principal do app
import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/widgets/category-item.widget.dart';
import 'package:pet_app_qrcode/widgets/category-list.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pet Finder",
          style: TextStyle(color: Colors.purple, fontSize: 40),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Icon(Icons.qr_code),
          ),
        ],
        leading: Image.asset("assets/logo_pet.png"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.asset("assets/banner_home.png"),
              margin: const EdgeInsets.all(0.1),
              height: 180.0,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Categorias",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.purple,
              ),
            ),
            CategoryList(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Meus Pets",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.purple,
                  ),
                ),
                Container(
                  height: 32,
                  child: FloatingActionButton(
                      child: const Icon(Icons.add), onPressed: () {}),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: Image.asset("assets/pets.jpg")),
          ],
        ),
      ),
    );
  }
}
