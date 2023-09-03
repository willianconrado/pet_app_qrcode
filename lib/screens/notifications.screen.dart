import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(
            color: Colors.black,
          ),
        ), // Título da AppBar
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // Centralize o conteúdo horizontalmente
          children: <Widget>[
            Image.asset("assets/notifications.png"),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Sem novas notificações",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Fique atento! Nós te avisaremos sobre qualquer atualização envolvendo seu pet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
