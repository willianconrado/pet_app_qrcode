import 'package:flutter/material.dart';
import 'category-item.widget.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CategoryItem(image: "assets/category_dog.jpg", text: "Cuidados"),
        CategoryItem(image: "assets/logo_pet.png", text: "Medicamentos"),
        CategoryItem(image: "assets/category_cat.jpg", text: "Vacinação"),
        CategoryItem(image: "assets/category_dog_1.jpg", text: "Consultas"),
      ],
    );
  }
}
