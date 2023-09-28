import 'package:flutter/material.dart';
import 'package:pet_app_qrcode/screens/homepage/home.screen.dart';
import 'package:pet_app_qrcode/screens/notifications.screen.dart';
import 'package:pet_app_qrcode/screens/profilepage/profile.screen.dart';
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
              icon: Icon(Icons.home),
              text: 'Início',
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              text: 'Agenda',
            ),
            Tab(
              icon: Icon(Icons.notifications),
              text: 'Notificações',
            ),
            Tab(
              icon: Icon(Icons.person),
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
