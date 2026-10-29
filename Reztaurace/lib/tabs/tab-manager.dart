import 'package:flutter/material.dart';
import 'tab1-home.dart';
import 'tab2-map.dart';
import 'tab3-menu.dart';
import 'tab4-calendar.dart';
import 'tab5-settings.dart';

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

