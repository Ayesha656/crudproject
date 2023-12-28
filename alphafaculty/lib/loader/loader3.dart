import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader3 extends StatefulWidget {
  const Loader3({super.key});

  @override
  State<Loader3> createState() => _Loader3State();
}

class _Loader3State extends State<Loader3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 500,
                    color: const Color(0xFFFCD91E),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("images/pg3.gif"), fit: BoxFit.cover)),
                      ),

                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Let's Start A New Journey", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  )),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text("Lorem Ipsum is simply dummy text"),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

          ]
      ),
    );
  }
}
