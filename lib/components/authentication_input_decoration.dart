import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
      borderSide: const BorderSide(color: Colors.blue, width: 4),
    ),
  );
}