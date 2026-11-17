import 'package:flutter/material.dart';
import 'package:reztaurace/data/restaurant_data.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget{
  final String phone;
  const CallButton({super.key, required this.phone});

  Future<void> _makePhoneCall(BuildContext context) async {
    final launchUri = Uri(scheme: 'tel', path: phone);
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
      onPressed: phone.isEmpty ? null : () => _makePhoneCall(context),
      label: const Text("Zavolat")
    );
  }
}