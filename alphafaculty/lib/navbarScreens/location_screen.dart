import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        height: double.infinity,

        child: Image.asset("images/map.png",
        fit: BoxFit.cover,)
        ,
      )
    );
  }
}
