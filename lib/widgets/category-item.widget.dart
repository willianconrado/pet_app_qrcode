import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  String image;
  String text;

  CategoryItem({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          margin: const EdgeInsets.all(5),
          child: Material(
            elevation: 2,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {
                //Implementar a condição: Se não tiver pet cadastrado apresentar a mensagem, senão ir para a pagina do objeto cliclado

                final snackBar = SnackBar(
                  content: const Text("Você não possui nenhum pet cadastrado."),
                  backgroundColor: Colors.red[400],
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
