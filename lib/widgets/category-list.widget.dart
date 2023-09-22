import 'package:flutter/material.dart';
import 'category-item.widget.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CategoryItem(image: "assets/category_doctor.jpg", text: "Cuidados"),
        CategoryItem(image: "assets/category_dog_1.jpg", text: "Medicação"),
        CategoryItem(image: "assets/category_dog.jpg", text: "Vacinação"),
        CategoryItem(image: "assets/category_doctor_1.jpg", text: "Consultas"),
      ],
    );
  }
}
