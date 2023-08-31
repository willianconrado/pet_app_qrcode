import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkValue = false;

  void _validatingCheckbox() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset("assets/logo.png"),
              const SizedBox(
                height: 32,
              ),
              const Text(
                "Cuide de quem você ama!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
                "Com o PET FINDER seu amigo volta para casa, além de inúmeras outras vantagens.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (checkValue) {
                        _validatingCheckbox();
                        print("Deu bom carai");
                      } else {
                        const snackBar = SnackBar(
                          content: Text(
                              "Assine os termos antes de logar na sua conta!"),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("TNC carai, aceita os termo ai, porra!");
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                          width: 120,
                          child: Image.asset(
                            "assets/facebook.png",
                          ),
                        ),
                        const Text(
                          "Continuar com Facebook",
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (checkValue) {
                        _validatingCheckbox();
                        print("Deu bom carai");
                      } else {
                        const snackBar = SnackBar(
                          content: Text(
                              "Assine os termos antes de logar na sua conta!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("TNC carai, aceita os termo ai, porra!");
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                          width: 120,
                          child: Image.asset(
                            "assets/google.png",
                          ),
                        ),
                        const Text("Continuar com Google"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Row(
                  children: [
                    Checkbox(
                      value: checkValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkValue = value!;
                        });
                      },
                    ),
                    const Flexible(
                      child: Text(
                          "Ao criar sua conta, você concorda com os nossos TERMOS DE USO e a POLITICA DE PRIVACIDADE."),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
