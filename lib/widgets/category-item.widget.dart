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
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(7),
          child: Material(
            elevation: 2,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {},
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
