import 'package:flutter/material.dart';

class Restaurace extends StatelessWidget{
  const Restaurace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurace"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
    );
  }
}