import 'package:flutter/material.dart';
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
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: appBar(),
            bottomNavigationBar: Container(
              decoration: BoxDecoration( //Nastaveni border nad navigation barem
                border: Border(
                  top: BorderSide(
                    color: Colors.black, width: 2
                  )
                )
              ),
              child: TabBar(
                  indicatorColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.food_bank)),
                    Tab(icon: Icon(Icons.local_restaurant)),
                    Tab(icon: Icon(Icons.calendar_month)),
                    Tab(icon: Icon(Icons.settings))
                  ]
              ),
            ),
            body: const TabBarView(
              children: [
                Home(),
                MapaRestauraci(),
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

AppBar appBar() {
    return AppBar(
      title: const Text(
        'Reztaurace',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
    );
  }