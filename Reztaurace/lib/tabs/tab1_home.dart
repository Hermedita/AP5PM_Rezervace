import 'package:flutter/material.dart';
import '../data/restaurant_data.dart';
import '../states/state_restaurant.dart';

import '../widgets/slideshow.dart';
import '../widgets/circle_list_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override

  Widget build(BuildContext context) {
    return ListView(
      children: [
        //child 1 - text
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
              textAlign: TextAlign.center,
              "Domovská stránka"),
        ),

        //child 2 - round icons
        RowList(
          items: [
            CircleListItem(
                image: 'assets/images/trans_001.png',
                onTap: (){
                  DefaultTabController.of(context).animateTo(2);
                }),
            CircleListItem(
                image: 'assets/images/trans_002.png',
                onTap: (){
                  DefaultTabController.of(context).animateTo(3);
                }),
            CircleListItem(
                image: 'assets/images/trans_003.png',
                onTap: (){
                  DefaultTabController.of(context).animateTo(4);
                }),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(20),
        ),

        //child 3 - slideshow
        ImageSlideshow(
          height: 220,
          slides: [
            for (final r in restaurants)
              SlideItem(
                image: r.image,
                name: r.name,
                place: r.place,

                onTap: () {
                  selectedRestaurant.value = r;
                  DefaultTabController.of(context).animateTo(1);
                 },
                ),
          ],
        ),
      ],
    );
  }
}