import '../models/menuItem.dart';

Future<List<MenuItem>> fetchMenu(int restaurantId) async {
  await Future.delayed(const Duration(milliseconds: 350));
  return menuitems.where((item) => item.restaurantid == restaurantId).toList();
}

const menuitems = [
  MenuItem(
    id: 0001,
    restaurantid: 0001,
    name: 'Svíčková',
    image: 'assets/images/menufood/001_food.jpg',
    price: 189,
    description: 'Mrkev :)'
  ),
  MenuItem(
    id: 0002,
    restaurantid: 0002,
    name: 'Vepřo knedlo zelo',
    image: 'assets/images/menufood/002_food.jpg',
    price: 199,
    description: 'Vepřové maso s karlovarským knedlíkem a kysaným zelím'
  ),
];