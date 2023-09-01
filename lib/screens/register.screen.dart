import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/services/service.auth.dart';

import '../components/authentication.input.decoration.dart';

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
  final TextEditingController _phoneController = TextEditingController();

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
                                  return "o E-mail é muito curto";
                                }
                                if (!value.contains("@")) {
                                  return "o E-mail não é válido";
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
                                  return "o nome é muito curto";
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
                                if (value == null) {
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
                                if (value == null) {
                                  return "A Confirmação de senha não pode ser vázia";
                                }
                                if (value == _passwordController) {
                                  return null;
                                } else {
                                  return "As senhas não são iguais!";
                                }
                              },
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              decoration:
                                  getAuthenticationInputDecoration("Telefone"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O telefone não pode ser vázio";
                                }
                                if (value.length < 8) {
                                  return "O telefone não pode ser vázio é muito curto";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 40,
                              width: 310,
                              child: ElevatedButton(
                                onPressed: () {
                                  buttonRegisterPressed();
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
          "${_emailController.text}, ${_passwordController.text}, ${_nameController.text}, ${_phoneController.text}, ");
      _authenService.registerUser(email: email, password: password, name: name);
    } else {
      print("Form inválido");
    }
  }
}
