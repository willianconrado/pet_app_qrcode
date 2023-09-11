import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future<void> _refreshNotifications() async {
    // Implementar a lógica das notificaçãoes
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Atualizar a lista de notificações
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Notificações',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView(children: [
          Column(
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
        ]),
      ),
    );
  }
}
