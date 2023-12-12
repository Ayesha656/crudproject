import 'dart:async';

import 'package:app/loader1.dart';
import 'package:flutter/material.dart';

class fscreen extends StatefulWidget {
  const fscreen({super.key});

  @override
  State<fscreen> createState() => _fscreenState();
}

class _fscreenState extends State<fscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loader1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
         Center(
           child: Container(
            color: Colors.white,
            width: 200,
            height: 200,
            child: Image.asset('images/logo.png')),
      ),
    ]));
  }
}
