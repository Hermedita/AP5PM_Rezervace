import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:reztaurace/data/restaurant_data.dart';

class MapaRestauraci extends StatefulWidget{
  const MapaRestauraci({super.key});

  @override
  State<MapaRestauraci> createState() => _MapaRestauraciState();
}

class _MapaRestauraciState extends State<MapaRestauraci> {
  var showMap = false;

  @override
  void initState() {
    super.initState();
    getPermissionStatus();
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
    var status = await Permission.location.status;
    if(status.isDenied){
      await getPermission();
    }else if(status.isPermanentlyDenied){
      openAppSettings();
    }else{
      showMap = true;
    }
  }

  Future<void> getPermission() async {
    var locationPermission = await Permission.location.request();
    if(locationPermission.isDenied){
      showMap = false;
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
          onPressed:() => {
            setState(() async {
              await getPermission();
            })
          },
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
              initialCenter: LatLng(51.509364, -0.128928),
              initialZoom: 8.0
            ),
          children: [
            TileLayer(
              urlTemplate: '',
            ),
          ],          
        ),
        SlidingUpPanel(
          backdropEnabled: true,
          panel: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.grey.shade800,
                  height: 20,
                  indent: 150,
                  endIndent: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      restaurants[0].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Adresa: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26
                      )
                    ),
                    Text(
                      restaurants[0].place,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Otevírací doba: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24
                      )
                    ),
                    Text(
                      "10:00 - 16:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20
                ),
                Text(
                  "Popis ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                  ),
                ),
                SizedBox(
                  height: 20
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            backgroundColor: Colors.black,
                            minimumSize: Size(105, 60),
                            iconSize: 40,
                            iconColor: Colors.white,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            )
                          ),
                          icon: const Icon(Icons.menu_book),
                          onPressed: () => {
                    
                          },
                          label: const Text("Menu"),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.local_phone),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            backgroundColor: Colors.green,
                            minimumSize: Size(105, 60),
                            iconSize: 40,
                            iconColor: Colors.white,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            )
                          ),
                          onPressed: () => {
                    
                          },
                          label: const Text("Zavolat"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          collapsed: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.grey.shade800,
                  height: 20,
                  indent: 150,
                  endIndent: 150,
                ),
              ],
            ),
          ),
          borderRadius: borderRadius,
        ),
      ],
    );
  }
}