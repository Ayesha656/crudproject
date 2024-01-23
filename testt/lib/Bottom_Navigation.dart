import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Checkout/Add_to_Cart.dart';
import 'FeedBack_Screen.dart';
import 'Profile_Firebase_Firestore/Profile_Screen.dart';
import 'home/Home.dart';
import 'home/favourite.dart';


class bottomNavigation extends StatefulWidget {
  const bottomNavigation({super.key});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {

  int selectedIndex=0;
  void pageShifter(index){
    setState(() {
      selectedIndex=index;
    });
  }

  List<Widget> myScreens=[
    const HomePage(),
    const FavouriteList(),
    AddToCart(),
    const FeedbackScreen(),
    const profileScreen()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:myScreens[selectedIndex],

        bottomNavigationBar: CurvedNavigationBar(
            index: selectedIndex,
            backgroundColor: const Color(0xffffffff),
            color: const Color(0xf0002525),
            onTap: pageShifter,
            items: [
              Icon(Icons.home_filled, color: selectedIndex!=0? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.favorite_border, color: selectedIndex!=1? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.shopping_cart_outlined, color: selectedIndex!=2? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.feedback,color: selectedIndex!=3? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.person_2_outlined,color:  selectedIndex!=4? const Color(0xffffffff):
              const Color(0xf0a9a9a9),)
            ])


    );
  }
}
