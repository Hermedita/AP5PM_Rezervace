import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'tab1_home.dart';
import 'tab2_map.dart';
import 'tab3_menu.dart';
import 'tab4_calendar.dart';
import 'tab5_settings.dart';

class TabManager extends StatelessWidget{
  const TabManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: const Text('Reztaurace'),
              backgroundColor: Colors.green,
            ),
            bottomNavigationBar: TabBar(
                indicatorColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Domů",),
                  Tab(icon: Icon(Icons.food_bank), text: "Restaurace",),
                  Tab(icon: Icon(Icons.local_restaurant), text: "Menu",),
                  Tab(icon: Icon(Icons.calendar_month), text: "Kalendář",),
                  Tab(icon: Icon(Icons.settings), text: "Nastavení",)
                ]
            ),
            body: const TabBarView(
              children: [
                Home(),
                Restaurace(),
                Menu(),
                Kalendar(),
                Nastaveni()
              ],
            ),
          ),
        )
    );
  }
}

