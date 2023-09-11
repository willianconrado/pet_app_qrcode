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
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: ListView(
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
          const SizedBox(
            height: 8,
          ),
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
          const SizedBox(
            height: 32,
          ),
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
      ),

      /*Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/banner_home.png"),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
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
            const SizedBox(
              height: 16,
            ),
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
          ],
        ),
      ),*/
    );
  }
}
