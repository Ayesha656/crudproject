import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  List headings = ["What is the duration of a course?","What is the duration of a course?","What is the duration of a course?","What is the duration of a course?","What is the duration of a course?"];

  List subheadings = ["It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Text("FAQ", style: GoogleFonts.roboto(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold ),),
                ListView.builder(
                  itemCount: headings.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                  return Container(
                    padding:  const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12)
                    ),
                    child: ExpansionTile(title: Text(headings[index], style: GoogleFonts.roboto(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold ) ,),
                      children: [
                        ListTile(title: Text(subheadings[index],)
                        )
                      ],
                    ),
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
