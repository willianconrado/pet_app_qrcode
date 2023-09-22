import 'package:flutter/material.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Complete o endereço",
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            // Tamanho do card
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Rua",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Número",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Complemento",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Bairro",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Cidade",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Estado",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "Ponto de Referência",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[30],
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Definir endereço'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
