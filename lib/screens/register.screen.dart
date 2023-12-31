import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/_core/my.snackbar.dart';
import '../components/authentication.input.decoration.dart';

import '../services/service.auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool wanttoJoin = true;
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
                                if (value == null || value == "") {
                                  return "O E-mail não pode ser vázio";
                                }
                                if (!value.contains("@") ||
                                    !value.contains(".") ||
                                    value.length < 4) {
                                  return "O E-mail não é válido";
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
                            Visibility(
                              visible: !wanttoJoin,
                              child: TextButton(
                                onPressed: () {
                                  forgotMyPassword();
                                },
                                child: Text("Esqueci minha senha."),
                              ),
                            ),
                            Visibility(
                              visible: wanttoJoin,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration:
                                        getAuthenticationInputDecoration(
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
                                  TextFormField(
                                    controller: _nameController,
                                    decoration:
                                        getAuthenticationInputDecoration(
                                            "Nome"),
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
                                ],
                              ),
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
                                child: Text(
                                  (wanttoJoin) ? "Cadastrar" : "Entrar",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            TextButton(
                                child: Text((wanttoJoin)
                                    ? "Já tem uma conta?"
                                    : "Ainda não tem uma conta?"),
                                onPressed: () {
                                  setState(() {
                                    wanttoJoin = !wanttoJoin;
                                  });
                                }),
                            TextButton(
                                child: const Text(
                                  'Entrar com o Google',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
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
      if (wanttoJoin) {
        userRegister(name: name, email: email, password: password);
      } else {
        userJoin(email: email, password: password);
      }
    }
  }

  userJoin({
    required String email,
    required String password,
  }) {
    authService.userJoin(email: email, password: password).then((String? erro) {
      if (erro != null) {
        showSnackBar(context: context, text: erro);
      } else {
        Navigator.pop(context);
      }
    });
  }

  userRegister({
    required name,
    required String email,
    required String password,
  }) {
    authService
        .userRegister(
      email: email,
      password: password,
      name: name,
    )
        .then((String? erro) {
      if (erro != null) {
        showSnackBar(context: context, text: erro);
      } else {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          authService.createUserInFirestore(currentUser.uid, name, email);
        }
        Navigator.pop(context);
      }
    });
  }

  forgotMyPassword() {
    String email = _emailController.text;
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController changeMyPasswordController =
              TextEditingController(text: email);
          return AlertDialog(
            title: const Text("Confirme o E-mail de redefinição de senha"),
            content: TextFormField(
              controller: changeMyPasswordController,
              decoration:
                  const InputDecoration(label: Text("Confirme o E-mail.")),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            actions: [
              TextButton(
                  onPressed: () {
                    authService
                        .changeMyPassword(
                            email: changeMyPasswordController.text)
                        .then(
                      (String? erro) {
                        if (erro == null) {
                          showSnackBar(
                            context: context,
                            text: "E-mail de redefinição enviado!",
                            isErro: false,
                          );
                        } else {
                          showSnackBar(context: context, text: erro);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: const Text("Redefinir senha"))
            ],
          );
        });
  }
}