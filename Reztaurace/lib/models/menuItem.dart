class MenuItem {
  final int id;
  final int restaurantid;
  final String name;
  final String image;
  final int price;
  final String description;

  const MenuItem({
    required this.id,
    required this.restaurantid,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}