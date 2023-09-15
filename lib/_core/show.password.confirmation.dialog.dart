import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/services/service.auth.dart';

import '../screens/register.screen.dart';

showPasswordConfirmationDialog({
  required BuildContext context,
  required String email,
}) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController passwordConfirmationController =
          TextEditingController();
      return AlertDialog(
        title: Text("Deseja remover a conta com o E-mail $email ?"),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              const Text(
                  "Para confirmar a remoção da conta, insira sua senha: "),
              TextFormField(
                controller: passwordConfirmationController,
                obscureText: true,
                decoration: const InputDecoration(label: Text("Senha")),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AuthService()
                  .removeAccount(password: passwordConfirmationController.text)
                  
                  .then((String? erro) {
                if (erro == null) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            },
            child: const Text("Excluir Conta"),
          )
        ],
      );
    },
  );
}
