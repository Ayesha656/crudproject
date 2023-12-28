import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  List imageslist = ["images/j1.jpg","images/j2.jpg"];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: CarouselSlider.builder(
            itemCount: 2,
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(imageslist[index]), )
                ),
              );
        }, options: CarouselOptions(
          viewportFraction: 1.0,
          autoPlay: true,
          height: 500
        )),
      ),
    );
  }
}
