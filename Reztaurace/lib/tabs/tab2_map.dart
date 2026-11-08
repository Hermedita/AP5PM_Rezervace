import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';

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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getPermissionStatus());
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

  Center mapView(){
    return Center(
      child: Text("There will be a map here!")
    );
  }
}