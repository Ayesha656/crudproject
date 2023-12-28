import 'package:alphafaculty/navbarScreens/main_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'loader2.dart';
import 'loader3.dart';

class Loader1 extends StatefulWidget {
  const Loader1({super.key});

  @override
  State<Loader1> createState() => _Loader1State();
}

class _Loader1State extends State<Loader1> {
  final pageshift = PageController( keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Expanded(
           flex: 5,
           child: PageView(
             controller: pageshift,
             children: [

               Column(
                 children: [
                   Container(
                     width: double.infinity,
                     height: 500,
                     color: const Color(0xFFFCD91E),
                     child: Center(
                       child: Container(
                         width: 300,
                         height: 300,
                         decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("images/pg.gif"), fit: BoxFit.cover)),
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
               const Loader2(),
              const Loader3()
             ],
           ),
         ),
          SmoothPageIndicator(
            controller: pageshift,
            count:  3,
            axisDirection: Axis.horizontal,
            effect:  const SwapEffect(
                spacing:  8.0,
                radius:  4.0,
                dotWidth:  24.0,
                dotHeight:  16.0,
                paintStyle:  PaintingStyle.stroke,
                strokeWidth:  1.5,
                dotColor:  Colors.grey,
                activeDotColor:  Color(0xFFFCD91E),
            ),
          ),
        Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: (){
                  pageshift.jumpToPage(2);
                },
                child: const Text("Skip", style: TextStyle(color: Color(0xFFFCD91E)),),
              ),
              GestureDetector(
                onTap: ()async{
                  pageshift.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
                  if(pageshift.page==2){
                    SharedPreferences oneTime = await SharedPreferences.getInstance();
                    oneTime.setBool("isPassed", true);
                    debugPrint("Done");
                      if(context.mounted){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarScreen(),));
                      }
                  }
                },
                child: const Text("Next", style: TextStyle(color: Colors.black,),

                ),
              ),

            ],
          ),
        ),
      ),
]
      )
    );
  }
}
