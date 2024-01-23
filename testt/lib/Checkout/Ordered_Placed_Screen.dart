import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/Admin/Dashboard.dart';

class OrderedPlaced extends StatefulWidget {
  const OrderedPlaced({super.key});

  @override
  State<OrderedPlaced> createState() => _OrderedPlacedState();
}

class _OrderedPlacedState extends State<OrderedPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),

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
                      child: Text("PENDING ORDERS" , style: GoogleFonts.akatab(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.white
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Check-Out").snapshots(),
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const CircularProgressIndicator();
                            }
                            if(snapshot.hasData){
                              var dataLength = snapshot.data!.docs.length;
                              return dataLength==0?const Center(
                                child: Text("Nothing To Show"),
                              ): ListView.builder(
                                itemCount: dataLength,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {

                                  //String adminId = snapshot.data!.docs[index].id;
                                  String name = snapshot.data!.docs[index]['User-name'];
                                  String email = snapshot.data!.docs[index]['User-email'];
                                  String address = snapshot.data!.docs[index]['User-address'];
                                  double amount = snapshot.data!.docs[index]['Total-amount'];



                                  return Container(
                                    margin: const EdgeInsets.only(top: 70,left: 5,right: 8),
                                    width: double.infinity,
                                    height: 350,
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
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20, top: 10),
                                          width: double.infinity ,
                                          height: 60,
                                          child:Text('User-Name: $name' , style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),),
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: double.infinity ,
                                          height: 60,
                                          child:Text('User-Email: $email' , style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),),
                                        ),

                                        const SizedBox(height: 5,),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: double.infinity ,
                                          height: 60,
                                          child:Text('User-Address: $address' , style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),),
                                        ),

                                        const SizedBox(height: 5,),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: double.infinity ,
                                          height: 60,
                                          child:Text('Total-Ammount: $amount' , style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),),
                                        ),

                                        const SizedBox(height: 10,),
                                        Column(
                                          children: [

                                            const SizedBox(width: 5,),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  child: Center(
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 8),
                                                      margin: EdgeInsets.only(left: 120),
                                                      width: 150,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.black,
                                                              blurRadius: 4,
                                                              offset: Offset(13, 10), // Shadow position
                                                            ),
                                                          ]
                                                      ),
                                                      child: Text("Order Placed" , style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.black
                                                      ),),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],


                                        )




                                      ],
                                    ),


                                  );



                                },);
                            }
                            if (snapshot.hasError) {
                              return const Icon(Icons.error_outline);
                            }
                            return Container();

                          },),

                        const SizedBox(height: 20,),

                      ],
                    ),
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
