import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context, required String text, bool isErro = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(text), backgroundColor: (isErro) ? Colors.red : Colors.green, 
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
