import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reztaurace/darkMode/setMode.dart';
import 'package:reztaurace/data/map_data.dart';
import 'package:reztaurace/data/restaurant_data.dart';
import 'package:reztaurace/states/state_restaurant.dart';

MapController mapController = MapController();

FlutterMap map() {
  return FlutterMap(
    mapController: mapController,
    options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: zoom
    ),
    children: [
      TileLayer(urlTemplate: isDarkMode ? "$mapUrl&style=dark3" : mapUrl),
      MarkerLayer(
        markers: [
          ...restaurants.map((r) => Marker(
            point: LatLng(r.lat, r.lng),
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => selectedRestaurant.value = r,
              child: Icon(Icons.location_on, color: isDarkMode ? const Color.fromARGB(255, 255, 0, 0) : Colors.amber, size: 40),
            ),
          )),
        ],
      ),
    ],
  );
}