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
          width: 70,
          height: 70,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.purple,
                offset: Offset(1, 1),
                blurRadius: 0.5,
                spreadRadius: 0.5,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(65),
            ),
          ),
          child: Image.asset(image),
        ),
        Text(text),
      ],
    );
  }
}
