import 'package:flutter/material.dart';
import 'package:reztaurace/data/menuItem_data.dart';
import 'package:reztaurace/data/restaurant_data.dart';
import 'package:reztaurace/widgets/menu_list_item.dart';

import '../models/menuItem.dart';
import '../models/restaurant.dart';
import '../states/state_restaurant.dart';

import 'package:reztaurace/darkMode/setMode.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();}

  class _MenuState extends State<Menu> {
    List<MenuItem> _menus = [];
    bool _loading_active = false;

  @override
  void initState() {
    super.initState();
    selectedRestaurant.addListener(_onRestaurantChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onRestaurantChanged());
  }

  @override
  void dispose() {
    selectedRestaurant.removeListener(_onRestaurantChanged);
    super.dispose();
  }

  Future<void> _onRestaurantChanged() async {
    final restaurant = selectedRestaurant.value;
    if (restaurant == null){
      if (!mounted) return;
      setState(() => _menus = []);
    }
    setState(() => _loading_active = true);
    final fetchedMenu = await fetchMenu(restaurant!.id);
    if (!mounted || selectedRestaurant.value?.id != restaurant.id) return;
    setState(() {
      _menus = fetchedMenu;
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
        if (_loading_active) const Center(child: CircularProgressIndicator())
        else
          MenuRowList(menuitems: _menus),
      ],
    );
  }
  );
}
}

