import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Dashboard.dart';

class AdminReview extends StatefulWidget {
  const AdminReview({super.key});

  @override
  State<AdminReview> createState() => _AdminReviewState();
}

class _AdminReviewState extends State<AdminReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            Colors.black,
                            Color(0xFF040B2D),
                            Colors.black
                          ]
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                        padding: const EdgeInsets.all(7.0),
                        margin: const EdgeInsets.only(left: 30,top: 30),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  AdminDashbaord()));
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded, // Arrow icon
                            size: 18, // Icon size
                            color: Colors.white, // Icon color (match the container background)
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 5,
                        padding: const EdgeInsets.all(7.0),
                        margin: const EdgeInsets.only(left: 150,top: 35),
                        decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(40)
                        ),
                      ),

                    ],),
                ),

                SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 30 , left: 100),
                      width: double.infinity,
                      height: 40,
                      child: Text("Product Reviews" , style: GoogleFonts.akatab(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.white
                      ),),
                    ),
                    SizedBox(height: 20,),

                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Product-Reviews").snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const CircularProgressIndicator();
                          }
                          if(snapshot.hasData){
                            var dataLength = snapshot.data!.docs.length;
                            return dataLength==0?const Center(
                              child: Text("Nothing To Show"),
                            ):ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                                itemCount: dataLength,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  String name = snapshot.data!.docs[index]['Product-Name'];
                                  String email = snapshot.data!.docs[index]['User-Email'];
                                  String message = snapshot.data!.docs[index]['Review-message'];
                                  num rating = snapshot.data!.docs[index]['Star-Rating'];

                                  return Container(
                                    margin: const EdgeInsets.only(top: 70,left: 8,right: 10),
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF040B2D),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4,
                                          offset: Offset(9, 8), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20, top: 20),
                                      width: double.infinity ,
                                      height: 60,
                                      child:Text('Product-Name: $name \n User-Email: $email \n Review-Message: $message \n Product-Rating: $rating' , style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),),
                                    ),
                                  );


                                },);
                          }
                          if (snapshot.hasError) {
                            return const Icon(Icons.error_outline);
                          }
                          return Container();
                        },)











                  ],
                ),

              ],

            )
          ],


        ),








      ),
    );
  }
}
