import 'package:flutter/material.dart';

class MenuListItem {
  final String name;
  final String image;
  final int price;
  final String description;

  const MenuListItem({
    required this.name,
    required this.image,
    required this.price,
    required this.description});
}

/*
|--------| name                        |
|  img   | descr.......       price Kč |
L________|  ...........                |
 */
class MenuRowList extends StatelessWidget{
  const MenuRowList({
    super.key,
    required this.menuitems,
    this.width = 80,
    this.height = 60,
  });
  final List<MenuListItem> menuitems;
  final double width;
  final double height;

  Widget _buildImage(String path){
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
      return Image.asset(
          path,
          fit: BoxFit.cover,
          width: width,
          height: height,
      );
    }


@override
  Widget build(BuildContext context){
    if (menuitems.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      padding: EdgeInsetsGeometry.all(15),
      itemBuilder: (context, i) {
      final menu = menuitems[i];
        return Container(
          child: Row(
            children: [
              //image
              Container(
                alignment: AlignmentGeometry.centerLeft,
                padding: EdgeInsetsDirectional.all(10),
                child: _buildImage(menu.image)
              ),
              //txt - name + description
              Column(
                children: [
                  Text(
                    menu.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid
                      ),
                    textAlign: TextAlign.left,
                    ),
                  Text(
                    menu.description,
                    softWrap: true,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              //cost
              Container(
                alignment: AlignmentGeometry.centerRight,
                padding: EdgeInsetsDirectional.all(10),
                child: Row(
                  children: [
                      Text(
                        menu.price as String,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(" Kč", style: TextStyle(fontStyle: FontStyle.italic))
                  ],
                ),
              )
            ],
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 1.0,
          width: double.infinity,
          child: ColoredBox(color: Color(0xFF000000)),
        );
      },
      itemCount: menuitems.length
    );
  }
}