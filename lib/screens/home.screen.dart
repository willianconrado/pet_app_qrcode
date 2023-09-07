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
              height: 200.0,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Categorias",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 120.0,
              child: CategoryList(),
            ),
            Container(
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
