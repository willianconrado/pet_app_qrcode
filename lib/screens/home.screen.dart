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
        leading: Image.asset("assets/logo_pet.png"),
        title: const Text(
          "Pet Finder",
          style: TextStyle(color: Colors.purple, fontSize: 40),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/banner_home.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Categorias",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.purple,
              ),
            ),
            const SizedBox(
              height: 8,
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
                SizedBox(
                  height: 32,
                  child: FloatingActionButton(
                      elevation: 1,
                      child: const Icon(Icons.add),
                      onPressed: () {}),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/pets.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),

            //Expanded(child: Image.asset("assets/pets.jpg")),
          ],
        ),
      ),
    );
  }
}
