import 'package:flutter/material.dart';
import 'package:reztaurace/data/restaurant_data.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget{
  const CallButton({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
        _makePhoneCall(restaurants[0].phone) //Zde je potřeba vyměnit restaurants[0] za vybranou restauraci, zde pouze pro testování
      },
      label: const Text("Zavolat")
    );
  }
}