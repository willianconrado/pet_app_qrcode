import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/_core/my.snackbar.dart';
import '../components/authentication.input.decoration.dart';
import '../services/service.auth.dart';
import 'tabs.screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool wanttoJoin = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService _authenService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 700,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            const Text(
                              "Cadastre-se!",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration:
                                  getAuthenticationInputDecoration("E-mail"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O E-mail não pode ser vázio";
                                }
                                if (value.length < 4) {
                                  return "O E-mail é muito curto";
                                }
                                if (!value.contains("@")) {
                                  return "O E-mail não é válido";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration:
                                  getAuthenticationInputDecoration("Nome"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O nome não pode ser vázio";
                                }
                                if (value.length < 3) {
                                  return "O nome é muito curto";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration:
                                  getAuthenticationInputDecoration("Senha"),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "A senha não pode ser vázia";
                                }
                                if (value.length < 5) {
                                  return "A senha é muito curta";
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: getAuthenticationInputDecoration(
                                  "Confirmar Senha"),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "A Confirmação de senha não pode ser vazia";
                                }
                                if (value != _passwordController.text) {
                                  return "As senhas não conferem";
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 40,
                              width: 310,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    buttonRegisterPressed();
                                
                                  }
                                },
                                child: const Text(
                                  "Cadastrar",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            TextButton(
                                child: const Text('Já tem uma conta?'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buttonRegisterPressed() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    if (_formKey.currentState!.validate()) {
      print("Form válido");
      print(
          "${_emailController.text}, ${_passwordController.text}, ${_nameController.text},");
      _authenService
          .registerUser(
        email: email,
        password: password,
        name: name,
      )
          .then(
        (String? erro) {
          if (erro != null) {
           //voltou com erro
           showSnackBar(context: context, text: erro);
          } else {
            //deu certo
             Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TabsPage()));
            showSnackBar(context: context, text: "Cadastro efetuado com sucesso", isErro: false);
          }
        },
      );
    } else {
      print("Form inválido");
    }
  }
}
