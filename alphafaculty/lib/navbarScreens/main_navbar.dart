import 'package:alphafaculty/navbarScreens/ads_screen.dart';
import 'package:alphafaculty/navbarScreens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Forms/signin.dart';
import 'call_screen.dart';
import 'faq_screen.dart';
import 'location_screen.dart';
class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {

  int selectedIndex = 4;

  void pageShifer(value){
    setState(() {
      selectedIndex = value;
    });
  }

  List<Widget> pages = const [
    FaqScreen(),
    AdsScreen(),
    CallScreen(),
    MessageScreen(),
    SigInScreen(),
    LocationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Aptech",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            onTap: pageShifer,
            currentIndex: selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.limeAccent,
            selectedLabelStyle: const TextStyle(color: Colors.limeAccent),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.question_mark),label: "FAQ's"),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book),label: "Ads"),
              BottomNavigationBarItem(icon: Icon(Icons.phone),label: "Call"),
              BottomNavigationBarItem(icon: Icon(Icons.message),label: "Message"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Signin"),
              BottomNavigationBarItem(icon: Icon(Icons.location_on),label: "Location"),

        ]),
      ),
    );
  }
}
