import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft,
              color: Colors.white, size: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "PULAR",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.purple,
    );
  }
}
