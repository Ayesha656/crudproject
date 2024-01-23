import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);


  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  Future getCheckinDetails() async {
    var request = http.Request(
      'GET',
      Uri.parse('http://10.0.1.243/alpha1/api/checkinout.php'),
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

                      String fid= dataLength[index]["faculty_id"];
                      String check_in = dataLength[index]["check_in"];
                      String check_out = dataLength[index]["check_out"];
                      String date = dataLength[index]["date"];
                      String batch_id = dataLength[index]["batch_id"];
                      String sro_id = dataLength[index]["sro_id"];

                        return Container(

                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                            title: Text(batch_id, style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            ),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Check In: $check_in",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),

                              ],
                            ),
                            expandedCrossAxisAlignment: CrossAxisAlignment
                                .start,
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,

                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 14),
                                width: double.infinity,
                                height: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: 220,
                                      child: Text("Check Out: $check_out",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400
                                        ), overflow: TextOverflow.ellipsis,),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                                  margin: const EdgeInsets.only(
                                      left: 14, top: 6),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
                                              child: Text("SRO Name: $sro_id",
                                                style: GoogleFonts.poppins(
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
                                              child: Text("Date: $date",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black,
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
