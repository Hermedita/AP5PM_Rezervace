import 'package:flutter/material.dart';

class CircleListItem {
  final String image;
  final VoidCallback? onTap;

  const CircleListItem({required this.image, this.onTap});
}

class RowList extends StatelessWidget{
  const RowList({
    super.key,
    required this.items,
    this.size = 80,
    this.spacing = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),

});
  final List<CircleListItem> items;
  final double size;
  final double spacing;
  final EdgeInsets padding;


  Widget _buildImage(String path){
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    }
      return Image.asset(
          path,
          fit: BoxFit.cover,
          width: size,
          height: size,
      );
    }

 @override
  Widget build(BuildContext context){
   if (items.isEmpty) return const SizedBox.shrink();

   return Center(
     child: SizedBox(
       height: size,
       child: ListView.separated(
         shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: padding,
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(width: spacing),
          itemBuilder: (context, i) {
            final item = items[i];
            return GestureDetector(
              onTap: item.onTap,
              child: ClipOval(
                  child: _buildImage(item.image)),
            );
          },
       ),
     ),
   );
  }
}

