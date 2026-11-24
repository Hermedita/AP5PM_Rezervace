import 'package:flutter/material.dart';
import '../models/menuItem.dart';

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
  final List<MenuItem> menuitems;
  final double width;
  final double height;

  Widget _buildImage(String path){
    if (path.startsWith('http')) {
      return Image.network(path,fit: BoxFit.cover,width: width,height: height,);
    }
      return Image.asset(path,fit: BoxFit.cover,width: width,height: height,);
    }


@override
  Widget build(BuildContext context){
    if (menuitems.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsetsGeometry.all(15),
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuitems.length,
      itemBuilder: (context, i) {
      final menu = menuitems[i];
        return Row(
            children: [
              //image
              Container(
                alignment: AlignmentGeometry.centerLeft,
                padding: EdgeInsetsDirectional.all(10),
                child: _buildImage(menu.image)
              ),
              //txt - name + description
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid),
                    ),
                  Text(
                    menu.description,
                    softWrap: true),
                  ],
                )
              ),

              //cost
              Container(
                alignment: AlignmentGeometry.centerRight,
                padding: EdgeInsetsDirectional.all(10),
                  child:
                    Text(
                    '${menu.price} Kč',
                     style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              )
            ],
          );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}