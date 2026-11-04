import 'package:flutter/material.dart';
import 'package:reztaurace/themes/app_themes.dart';
import 'tab1_home.dart';
import 'tab2_map.dart';
import 'tab3_menu.dart';
import 'tab4_calendar.dart';
import 'tab5_settings.dart';

class TabManager extends StatefulWidget{
  const TabManager({super.key});

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleMode(){
    setState(() {
      if(_themeMode == ThemeMode.light){
        _themeMode = ThemeMode.dark;
      }else{
        _themeMode = ThemeMode.light;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: lightMode,
      darkTheme: darkMode,
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
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.food_bank)),
                  Tab(icon: Icon(Icons.local_restaurant)),
                  Tab(icon: Icon(Icons.calendar_month)),
                  Tab(icon: Icon(Icons.settings))
                ]
            ),
          ),
          body: TabBarView(
            children: [
              const Home(),
              const MapaRestauraci(),
              const Menu(),
              const Kalendar(),
              Nastaveni(
                themeMode: _themeMode,
                toggleMode: _toggleMode,
                )
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
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }