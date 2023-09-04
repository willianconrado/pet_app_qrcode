import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/screens/home.screen.dart';
import 'package:pet_app_qrcode/screens/notifications.screen.dart';
import 'package:pet_app_qrcode/screens/profile.screen.dart';
import 'package:pet_app_qrcode/screens/schedule.screen.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            SchedulePage(),
            NotificationsPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
          tabs: [
            Tab(
              icon: Icon(Icons.home), // Ícone para a HomePage
              text: 'Início',
            ),
            Tab(
              icon: Icon(Icons.calendar_today), // Ícone para a SchedulePage
              text: 'Agenda',
            ),
            Tab(
              icon: Icon(Icons.notifications), // Ícone para a NotificationsPage
              text: 'Notificações',
            ),
            Tab(
              icon: Icon(Icons.person), // Ícone para a ProfilePage
              text: 'Perfil',
            ),
          ],
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.black45,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.black,
        ),
      ),
    );
  }
}