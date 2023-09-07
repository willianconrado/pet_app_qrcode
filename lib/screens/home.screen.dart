// Aqui ficara a pagina principal do app
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.asset("assets/banner_home.png"),
              margin: const EdgeInsets.all(0.1),
              height: 180.0,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Categorias",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 120.0,
              child: CategoryList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Meus Pets",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                FloatingActionButton(onPressed: () {}),
              ],
            ),
            Container(
              child: Image.asset("assets/banner_home.png"),
              margin: const EdgeInsets.all(10.0),
              color: Colors.blue[600],
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
