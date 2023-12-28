import 'package:app/Signup.dart';
import 'package:app/loader2.dart';
import 'package:app/loader3.dart';
import 'package:app/loader4.dart';
import 'package:app/signup2.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class loader1 extends StatefulWidget {
  const loader1({super.key});

  @override
  State<loader1> createState() => _loader1State();
}

class _loader1State extends State<loader1> {
  @override

  final _controller = PageController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: [

                loader2(),
                loader3(),
                loader4(),
                signup(),
                signup2()
              ],
            ),
          ),
          SmoothPageIndicator(
              controller: _controller,
              count: 5,
            effect: SwapEffect(
              activeDotColor: Colors.pink,
              dotColor: Colors.pink.withOpacity(0.5)
            ),
          )
        ],
      ),
    );
  }
}
