import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:reztaurace/data/themes/colors.dart';
import 'package:reztaurace/widgets/map.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:reztaurace/widgets/call_button.dart';

import 'package:reztaurace/states/state_restaurant.dart';

import 'package:reztaurace/models/restaurant.dart';

import 'package:reztaurace/darkMode/setMode.dart';
import 'package:reztaurace/data/map_data.dart';

import '../models/openingDay_enum.dart';

class MapaRestauraci extends StatefulWidget{
  const MapaRestauraci({super.key});

  @override
  State<MapaRestauraci> createState() => _MapaRestauraciState();
}

class _MapaRestauraciState extends State<MapaRestauraci> {
  var _loading_active = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getLocationPermission(false));
    retrieveThemeMode();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showMap ? mapView() : permissionNotGiven()
      )
    );
  }

  Column permissionNotGiven(){
    return Column(
      children: [
        locationInfoTitle(),
        locationInfo(),
        locationInfoImage(),
        SizedBox(height: 10),
        if (_loading_active) const Center(child: CircularProgressIndicator()),
        SizedBox(height: 10),
        shareLocationButton(),
        SizedBox(height: 10),
        showMapButton()
      ],
    );
  }

  Stack mapView(){
    var borderRadius = BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0));
    return Stack(
      children: [
        map(),
        slideUpPanel(borderRadius),
        locationGiven ? floatingButtonLocationGiven() : floatingButtonLocationNotGiven(),
        ],
    );
  }

  Padding floatingButtonLocationNotGiven() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        onPressed: () => {
          setState(() {
            showMap = false;
          })
        },
        child:
          Icon(Icons.location_off, color: isDarkMode ? Colors.white : Colors.grey.shade800),
      ),
    );
  }

  Padding floatingButtonLocationGiven() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        onPressed: () => {
          setState(() {
            mapController.move(LatLng(latitude, longitude), zoom);
          })
        },
        child:
          Icon(Icons.location_searching, color: isDarkMode ? Colors.white : Colors.grey.shade800),
      ),
    );
  }

  Padding showMapButton() {
    return Padding(
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
    );
  }

  ElevatedButton shareLocationButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        minimumSize: Size(250, 60)
        ),
      onPressed:() => getLocationPermission(true),
      child: Text(
        "Sdílet polohu",
        style: TextStyle(
            color: Colors.black,
            fontSize: 21
        ),
      ),
    );
  }

  Expanded locationInfoImage() {
    return Expanded(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Image(
                image: AssetImage("assets/images/restaurant_location.png")
            ),
          )
      ),
    );
  }

  Center locationInfo() {
    return Center(
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
    );
  }

  Center locationInfoTitle() {
    return Center(
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
    );
  }

  SlidingUpPanel slideUpPanel(BorderRadius borderRadius) {
    return SlidingUpPanel(
      color: isDarkMode ? Colors.grey.shade900 : Colors.white,
      backdropEnabled: true,
      borderRadius: borderRadius,
      collapsed: collapsedPanel(),
      panel: changeRestaurant(),
    );
  }

  Center collapsedPanel() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(height: 20, indent: 150, endIndent: 150),
        ],
      ),
    );
  }

  ValueListenableBuilder<Restaurant?> changeRestaurant() {
    return ValueListenableBuilder<Restaurant?>(
        valueListenable: selectedRestaurant,
        builder: (context, restaurant, _){
          if (restaurant == null) {
            return const Center(child: Text('Vyberte restauraci na mapě'));
          }
          return Center(
            child: Column(
              children: [
              restaurantNameRow(restaurant),
              SizedBox(height: 20),
              addressRow(restaurant),
              SizedBox(height: 20),
              openingHoursRow(restaurant),
              SizedBox(height: 20),
              descriptionRow(restaurant),
              SizedBox(height: 20),
              buttonRow(restaurant),
            ],
          ),
        );
      },
    );
  }

  Container restaurantNameRow(Restaurant restaurant) {
    return Container(
      color: isDarkMode ? titlesUglyCervena : titlesSvetleModra,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 85),
          Text(
            restaurant.name,
            style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Row addressRow(Restaurant restaurant) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20,),
          Text(
            "Adresa: ",
            style: TextStyle(
              fontSize: 26
            )
          ),
        Text(
          restaurant.place,
          style: TextStyle(
            fontSize: 24
          ),
        ),
      ],
    );
  }

  Row openingHoursRow(Restaurant restaurant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Otevírací doba: ",
            style: TextStyle(
              fontSize: 24)
        ),
        Text(
          _todayHours(restaurant),
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  Row descriptionRow(Restaurant restaurant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Popis:",
                  style: TextStyle(
                    fontSize: 24),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  restaurant.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buttonRow(Restaurant restaurant) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            menuButton(
            onTap:(){
            DefaultTabController.of(context).animateTo(2);
            }),
            CallButton(phone: restaurant.phone),
          ],
        ),
      ),
    );
  }

  ElevatedButton menuButton({required Null Function() onTap}) {
    return ElevatedButton.icon(
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
      label: const Text("Menu", style: TextStyle(color: Colors.white)),
    );
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

  Future<void> getLocationPermission(bool isBtn) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(!mounted) return;
        return Future.error('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        if(isBtn){
          Geolocator.openAppSettings();
        }
        if(!mounted) return;
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }else{
        Position? position = await Geolocator.getLastKnownPosition();
        if(position == null){
          setState(() => _loading_active = true);
          position = await Geolocator.getCurrentPosition();
        }
        setState(() {
          _loading_active = false;
          latitude = position!.latitude;
          longitude = position.longitude;
          zoom = 13.0;
          locationGiven = true;
          showMap = true;
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if(isBtn){
        Geolocator.openAppSettings();
      }
      if(!mounted) return;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }else{
      Position? position = await Geolocator.getLastKnownPosition();
      if(position == null){
        setState(() => _loading_active = true);
        position = await Geolocator.getCurrentPosition();
      }
      setState((){
        _loading_active = false;
        latitude = position!.latitude;
        longitude = position.longitude;
        zoom = 13.0;
        locationGiven = true;
        showMap = true;
      });
    }
  }
}