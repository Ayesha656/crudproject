import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as  http;
class current_batches extends StatefulWidget {
  const current_batches({super.key, required this.facultyid}

      );
  final String facultyid;
  @override
  State<current_batches> createState() => _current_batchesState();
}

class _current_batchesState extends State<current_batches> {
  Future getCheckinDetails() async {
    var request = http.Request(
      'GET',
      Uri.parse('http://10.0.1.243/alpha1/api/batches.php?faculty_id=${widget.facultyid}'),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      debugPrint(res);
      return res;
    } else {
      debugPrint(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Check-in Details'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Check-in Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Displaying data in cards
            FutureBuilder(
              future: getCheckinDetails(),
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }

                if(snapshot.hasData){

                  Map map = jsonDecode("${snapshot.data}");
                  List dataLength = map["data"];
                  return ListView.builder(
                    itemCount: dataLength.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {

                      String book= dataLength[index]["book"];
                      String startdate = dataLength[index]["start_date"];
                      String slot = dataLength[index]["time_id"];
                      String booksession = dataLength[index]["book_session"];
                      String day_id = dataLength[index]["day_id"];
                      String batch  =  dataLength[index]["batch"];


                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 1
                              )
                            ]
                        ),
                        child: ExpansionTile(
                          title: Text(book,style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Date: $startdate",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),),
                              slot=="1"?Text("9-11",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "2"?Text("11-1",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "2"?Text("11-1",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "3"?Text("1-3",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "4"?Text("3-5",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "5"?Text("5-7",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):slot == "5"?Text("7-9",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),):Text("",style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600
                              ),)

                            ],
                          ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          collapsedTextColor: Colors.black,

                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 14),
                              width: double.infinity,
                              height: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 220,
                                    child: Text("Book Session: $booksession",style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400
                                    ),overflow: TextOverflow.ellipsis,),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 10
                                    )
                                  ]
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 14,top: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                        const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: Colors.black,
                                        ),

                                        const SizedBox(
                                          width: 6,
                                        ),

                                        SizedBox(
                                            width: 270,
                                            child:  day_id=="1"?Text("MWF",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                            ),):Text("TTS",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                            ),)
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [

                                        const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        SizedBox(
                                            width: 270,
                                            child:  Text("Batch: $batch",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600
                                            ),)
                                        ),



                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },);
                }

                if(snapshot.hasError){
                  return Icon(Icons.error);
                }

                return Container();
              },)
          ],
        ),
      ),
    );
  }
}
