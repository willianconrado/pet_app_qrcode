import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Verifica se o e-mail já está verificado logo de cara
    isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      // Timer para checar automaticamente a cada 3 segundos se ele clicou no link
      // Isso permite que o usuário não precise clicar em nada após verificar no e-mail
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // É necessário dar um reload no usuário para atualizar o status do "emailVerified"
    // Caso contrário, o Firebase Auth mantém o estado em cache
    await FirebaseAuth.instance.currentUser?.reload();

    if (mounted) {
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      });

      if (isEmailVerified) {
        timer?.cancel();
        // O MapRouter no main.dart vai detectar a mudança e levar para a TabsPage
      }
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10)); // Evita spam de e-mails
      if (mounted) setState(() => canResendEmail = true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail de verificação enviado! Verifique sua caixa de entrada ou spam.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar e-mail: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Scaffold(body: Center(child: CircularProgressIndicator()))
      : Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Verifique seu E-mail',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 120,
                  color: Colors.purple,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Quase lá!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enviamos um link de confirmação para o seu e-mail. Por favor, clique nele para ativar sua conta.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.email),
                  label: const Text(
                    'Reenviar E-mail',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text(
                    'Cancelar e voltar ao login',
                    style: TextStyle(fontSize: 16, color: Colors.purple),
                  ),
                ),
                if (!canResendEmail)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Aguarde alguns segundos para reenviar...',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        );
}
