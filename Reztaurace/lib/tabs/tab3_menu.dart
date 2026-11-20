import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../states/state_restaurant.dart';

class Menu extends StatefulWidget{
  const Menu({
  super.key,
  required this.themeMode
  });
  final ThemeMode themeMode;

  @override
  State<Menu> createState() => _MenuState();}

  class _MenuState extends State<Menu> {
  bool showMenu = false;
  List<Menu> _menus = [];
  bool _loading_active = false;
  bool isDarkMode = false;


  @override
  void initState() {
    super.initState();
    selectedRestaurant.addListener(_onRestaurantChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onRestaurantChanged());
    //retrieveThemeMode();
  }

  @override
  void dispose() {
    selectedRestaurant.removeListener(_onRestaurantChanged);
    super.dispose();
  }

  Future<void> _onRestaurantChanged() async {
    final restaurant = selectedRestaurant.value;
    if (restaurant == null){
      setState(() => _menus = []);
      return;
    }
    setState(() => _loading_active = true);
    final menu = await fetchMenus(restaurant); //db call
    if (!mounted) return;
    setState(() {
      _menus = menu;
      _loading_active = false;
    });
  }


  @override
  Widget build(BuildContext context) {
      return ValueListenableBuilder<Restaurant?>(
        valueListenable: selectedRestaurant,
        builder: (context, restaurants, _){
          if (restaurants == null) {
            return const Center(
                child: Text('Vyberte restauraci na mapě'));
          }
    return ListView(
      children: [
        //child 1 - name of the restaurant
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(restaurants.name, textAlign: TextAlign.center),),
        //child 2 - list of menu items
      ],
    );
  }
  );
}
