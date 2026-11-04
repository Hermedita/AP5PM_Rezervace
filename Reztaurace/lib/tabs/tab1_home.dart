import 'package:flutter/material.dart';
import '../widgets/slideshow.dart';
import '../data/restaurant_data.dart';
import '../states/state_restaurant.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override

  Widget build(BuildContext context) {
    return ListView( //slideshow
      children: [
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
        const Padding(
            padding: EdgeInsets.all(16),
          child: Text("Domovská stránka"),
        ),
      ],
    );
  }
}