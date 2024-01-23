import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testt/Bottom_Navigation.dart';
import 'package:testt/firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'Firebase_Auth/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),

    );
  }
}
class UserSplash extends StatefulWidget {
  const UserSplash({super.key});

  @override
  State<UserSplash> createState() => _UserSplashState();
}

class _UserSplashState extends State<UserSplash> {

  @override

  void initState(){

    Timer(
      Duration(milliseconds: 14000),()=>
        FirebaseAuth.instance.currentUser!=null? Navigator.pushReplacement(
            context,
          MaterialPageRoute(builder: (context)=> bottomNavigation(),
          )
        )
            :Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),
        )
        )

      );
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 40,bottom: 20),
              height: 600,
              width: 600,
               child:  Lottie.asset('assets/animations/splashscreen.json',
                repeat: true,
                reverse: true,
              ),
            ),
          ),

        ],
      ),


    );
  }
}












