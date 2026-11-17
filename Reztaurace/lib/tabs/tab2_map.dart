import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:reztaurace/widgets/call_button.dart';

import 'package:reztaurace/states/state_restaurant.dart';

import 'package:reztaurace/models/restaurant.dart';

import '../data/restaurant_data.dart';
import '../models/openingDay_enum.dart';



class MapaRestauraci extends StatefulWidget{
  const MapaRestauraci({super.key});

  @override
  State<MapaRestauraci> createState() => _MapaRestauraciState();
}

class _MapaRestauraciState extends State<MapaRestauraci> {
  var showMap = false;
  var latitude = 50.08804;
  var longitude = 14.42076;

  @override
  void initState() {
    super.initState();
    getPermissionStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //dnesni oteviraci doba
  String _todayHours(Restaurant r) {
      final today = Day.values[DateTime.now().weekday - 1]; // enum order PO, UT, ST, CT, PA, SO, NE
      final matches = r.openingHours.where((o) => o.day == today);
        if (matches.isEmpty) return 'Dnes zavřeno';
        final h = matches.first;
      String f(TimeOfDay t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}';
      return '${f(h.from)} – ${f(h.to)}';
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(),
      body: Center(
        child: showMap ? mapView() : permissionNotGiven()
      )
    );
  }
/*
  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Mapa restaurací',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
    );
  }
*/
  Future<void> getPermissionStatus() async {
    final status = await Permission.location.status;
    if(status.isDenied){
      await getPermission();
    }else if(status.isPermanentlyDenied){
      openAppSettings();
    }else{
      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        showMap = true;
      });
    }
  }

  Future<void> getPermission() async {
    final locationPermission = await Permission.location.request();
    if(locationPermission.isGranted){
      final position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      showMap = true;
    } else {
      if(!mounted) return;
      setState(() => showMap = false);
    }
  }

  Column permissionNotGiven(){
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Údaje o poloze",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Pro použití mapy můžete poskytnout informace o své polohu nebo můžete rovnou mapu zobrazit.",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Image(
                    image: AssetImage("assets/images/restaurant_location.png")
                ),
              )
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            minimumSize: Size(250, 60)
            ),
          onPressed:() => getPermission(),
          child: Text(
            "Sdílet polohu",
            style: TextStyle(
                color: Colors.black,
                fontSize: 21
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(250, 60)
              ),
            onPressed:() => {
              setState(() {
                showMap = true;
              })
            },
            child: Text(
              "Přejít na mapu",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21
              ),
            ),
          ),
        )
      ],
    );
  }

  Stack mapView(){
    MapController mapController = MapController();    
    var borderRadius = BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0));
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
              initialCenter: LatLng(latitude, longitude),
              initialZoom: 13.4
            ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.tracestrack.com/_/{z}/{x}/{y}.webp?key=',),
            MarkerLayer(
            markers: [
              Marker(
              point: LatLng(latitude, longitude),
              width: 80,
              height: 80,
              child: const FlutterLogo(),
              ),
              ...restaurants.map((r) => Marker(
                point: LatLng(r.lat, r.lng),
                width: 80,
                height: 80,
                child: GestureDetector(
                onTap: () => selectedRestaurant.value = r,
                child: const Icon(Icons.location_on, color: Colors.amber, size: 40),
              ),
            )),
          ],
        ),
        ],
        ),
        SlidingUpPanel(
          backdropEnabled: true,
          borderRadius: borderRadius,
          collapsed: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(color: Colors.grey.shade800,height: 20,indent: 150,endIndent: 150,),
                ],
            ),
          ),
          panel: ValueListenableBuilder<Restaurant?>(
            valueListenable: selectedRestaurant,
            builder: (context, restaurant, _){
              if (restaurant == null) {
                return const Center(child: Text('Vyberte restauraci v mapě'));
              }
              return Center(
                child: Column(
                  children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Text(
                    restaurant.name,
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20,),
              Text(
                  "Adresa: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26 )
                  ),
              Text(
                restaurant.place,
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Otevírací doba: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24)
                    ),
                Text(
                  _todayHours(restaurant),
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                  ],
                ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Popis:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                color: Colors.black,
                fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.black,
                        minimumSize: Size(105, 60),
                        iconSize: 40,
                        iconColor: Colors.white,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20)
                        ),
                      icon: const Icon(Icons.menu_book),
                      onPressed: () => {},
                      label: const Text("Menu"),
                    ),
                    CallButton(phone: restaurant.phone),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    ),
        ),
                  ],
                );
}
/*
collapsed: Container(decoration: BoxDecoration(borderRadius: borderRadius,),
child: Column(mainAxisAlignment: MainAxisAlignment.start,
children: [Divider(color: Colors.grey.shade800,height: 20,indent: 150,endIndent: 150,),],),);
borderRadius: borderRadius;},),),],);}} */
}