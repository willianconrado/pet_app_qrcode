import 'package:flutter/material.dart';
import 'category-item.widget.dart';

class CategoryList extends StatelessWidget {
  final bool hasPets;
  const CategoryList({super.key, this.hasPets = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CategoryItem(
          image: "assets/category_doctor.jpg",
          text: "Cuidados",
          hasPets: hasPets,
        ),
        CategoryItem(
          image: "assets/category_dog_1.jpg",
          text: "Medicação",
          hasPets: hasPets,
        ),
        CategoryItem(
          image: "assets/category_dog.jpg",
          text: "Vacinação",
          hasPets: hasPets,
        ),
        CategoryItem(
          image: "assets/category_doctor_1.jpg",
          text: "Consultas",
          hasPets: hasPets,
        ),
      ],
    );
  }
}
