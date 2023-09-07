import 'package:flutter/material.dart';

import 'category-item.widget.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoryItem(
          image: "assets/logo_pet.png",
          text: "Cuidados",
        ),
        CategoryItem(
          image: "assets/logo_pet.png",
          text: "Medicamentos",
        ),
        CategoryItem(
          image: "assets/logo_pet.png",
          text: "Vacinação",
        ),
        CategoryItem(
          image: "assets/logo_pet.png",
          text: "Consultas",
        ),
      ],
    );
  }
}
