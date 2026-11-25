import '../models/menuItem.dart';

Future<List<MenuItem>> fetchMenu(int restaurantId) async {
  await Future.delayed(const Duration(milliseconds: 350));
  return menuitems.where((item) => item.restaurantid == restaurantId).toList();
}

const menuitems = [
  MenuItem(
    id: 0001,
    restaurantid: 0008,
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
  MenuItem(
      id: 0003,
      restaurantid: 0008,
      name: 'Řízek s bramborovým salátem',
      image: 'assets/images/menufood/003_food.png',
      price: 187,
      description: 'Vepřový řízek s bramborovým salátem'
  ),
  MenuItem(
      id: 0004,
      restaurantid: 0005,
      name: 'Chicken Tikka Masala',
      image: 'assets/images/menufood/004_food.png',
      price: 155,
      description: 'Příloha: Naan nebo rýže'
  ),
  MenuItem(
      id: 0005,
      restaurantid: 0005,
      name: 'Butter Chicken',
      image: 'assets/images/menufood/005_food.png',
      price: 147,
      description: 'Příloha: Naan nebo rýže'
  ),
  MenuItem(
      id: 0006,
      restaurantid: 0005,
      name: 'Krutí biryani s kari',
      image: 'assets/images/menufood/006_food.png',
      price: 163,
      description: 'Příloha: Rýže'
  ),
  MenuItem(
      id: 0007,
      restaurantid: 0005,
      name: 'Bhaji',
      image: 'assets/images/menufood/007_food.png',
      price: 171,
      description: 'Smažené cibulové smažené placky'
  ),
  MenuItem(
      id: 0008,
      restaurantid: 0005,
      name: 'Chicken Rogan Josh',
      image: 'assets/images/menufood/008_food.png',
      price: 188,
      description: 'Příloha: Naan nebo rýže'
  ),
  MenuItem(
      id: 0009,
      restaurantid: 0001,
      name: 'Pizza Marinara',
      image: 'assets/images/menufood/009_food.png',
      price: 196,
      description: 'Rajčatový základ, česnek, oregano a olivový olej'
  ),
  MenuItem(
      id: 0010,
      restaurantid: 0001,
      name: 'Pizza Diavola',
      image: 'assets/images/menufood/010_food.png',
      price: 205,
      description: 'Rajčatový základ, pikantní salám a mozzarella'
  ),
  MenuItem(
      id: 0011,
      restaurantid: 0006,
      name: 'Fugu',
      image: 'assets/images/menufood/011_food.png',
      price: 254,
      description: 'Důkladně připravená jedovatá ryba Fugu'
  ),
  MenuItem(
      id: 0012,
      restaurantid: 0006,
      name: 'Takoyaki',
      image: 'assets/images/menufood/012_food.png',
      price: 159,
      description: 'Tradiční japonské kuličky takoyaki s chobotnicí'
  ),
];