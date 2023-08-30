import 'package:flutter/material.dart';

class RegisterPhone extends StatelessWidget {
  const RegisterPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          width: 1000,
          height: 1000,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  "Informe-nos seu telefone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "É necessário para te localizar caso o animal se perca! 😉",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                ),
                width: 360,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: "Exemplo: +55 85 9545-3213",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    hintMaxLines: null,
                    labelText: "Número de telefone",
                  ),
                ),
              ),
              const SizedBox(
                height: 49,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
