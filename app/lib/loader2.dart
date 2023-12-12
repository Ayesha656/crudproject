import 'package:app/loader3.dart';
import 'package:app/loader4.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class loader2 extends StatefulWidget {
  const loader2({super.key});

  @override
  State<loader2> createState() => _loader2State();
}

class _loader2State extends State<loader2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Center(
                child: Text("Choose Product", style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,

                ),),
              ),


              Center(
                child: Container(
                    width: 400,
                    child: Image.asset("images/img1.png",width: 400,)
                ),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.", style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),

    );
  }
}
