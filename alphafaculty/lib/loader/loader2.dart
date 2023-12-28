import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader2 extends StatefulWidget {
  const Loader2({super.key});

  @override
  State<Loader2> createState() => _Loader2State();
}

class _Loader2State extends State<Loader2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("images/pg2.gif"), fit: BoxFit.cover)),
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
