import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context, required String text, bool isErro = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
