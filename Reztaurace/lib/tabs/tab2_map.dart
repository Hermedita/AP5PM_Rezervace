import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MapaRestauraci extends StatefulWidget{
  const MapaRestauraci({super.key});

  @override
  State<MapaRestauraci> createState() => _MapaRestauraciState();
}

class _MapaRestauraciState extends State<MapaRestauraci> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(),
      body: Center(
        child: permissionNotGiven()  
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
    if(await status.isDenied){
      permissionNotGiven();
    }else{
      mapView();
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
                  color: Colors.black,
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
                  color: Colors.black,
                  fontSize: 20,
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
            minimumSize: Size(250, 60)
            ),
          onPressed:() => {
            //checkLocationPermission();
            //Permission.location.request()
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