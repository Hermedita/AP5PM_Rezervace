import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  const Menu({
  super.key,
  required this.themeMode
  });
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //child 1 - name of the restaurant
        //child 2 - list of menu items
      ],
    );
  }
}
//reagujici na tab2