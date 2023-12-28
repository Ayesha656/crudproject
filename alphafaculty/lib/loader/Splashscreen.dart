import 'dart:async';

//import 'package:alphafaculty/dashboard_screen/current_activity.dart';
//import 'package:alphafaculty/dashboard_screen/home_screen.dart';
import 'package:alphafaculty/loader/loader1.dart';
import 'package:alphafaculty/loader/loader2.dart';
import 'package:alphafaculty/navbarScreens/main_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void screenShifter2(){
    Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loader1())),);
  }

  /* void screenShifter()async{
    SharedPreferences oneTime = await SharedPreferences.getInstance();
    var res = oneTime.getBool("isPassed");
    SharedPreferences studentLog = await SharedPreferences.getInstance();
    var stdLog = studentLog.getString('stdId');
    debugPrint("OneTime Screen: $res");
    debugPrint("Student Log: $stdLog");
    if(res == true){
      if(stdLog != null){
        Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loader1())),);
      }
      else{
        Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavbarScreen(),)),);
      }
    }
    else if(res == false){
      if(stdLog != null){
       Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loader2())),);
      }
      else{
        Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavbarScreen(),)),);
      }
    }
    else{
      Timer(const Duration(milliseconds: 3000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loader1(),)),);
    }
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    screenShifter2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        children: [
          Center(
                  child: SizedBox(
                 width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                   child: Image.asset('images/bg.png', // Replace with your image path
                  fit: BoxFit.cover,
            )
              ),
          ),

          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("images/images.png"))),
            ),
          )

        ],
      ),
    );
  }
}
