import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/Admin/Firebase_Firestore/product_Fetch.dart';
import 'package:testt/Firebase_Auth/Login_Screen.dart';
import 'Admin_Feedback_Screen.dart';
import 'Admin_Profile_Screen.dart';
import 'Admin_Review_Screen.dart';
import 'Admin_Order/Ordered_Placed_Screen.dart';

class AdminDashbaord extends StatefulWidget {
  const AdminDashbaord({super.key});

  @override
  State<AdminDashbaord> createState() => _AdminDashbaordState();
}
class _AdminDashbaordState extends State<AdminDashbaord> {

  double totalPrice = 0.0;

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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
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
                          margin: const EdgeInsets.only(left: 30,top: 50),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded, // Arrow icon
                              size: 18, // Icon size
                              color: Colors.white, // Icon color (match the container background)
                            ),
                          ),
                        ),


                      ],),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 50 , left: 140,right: 80),
                          width: double.infinity,
                          height: 40,

                          child: Text("DASHBOARD" , style: GoogleFonts.akatab(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30,),

              Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Product-Data').snapshots(),
                      builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                        var datalength = snapshot.data!.docs.length;
                        return datalength==0?const Center(
                          child: Text("Nothing To Show"),
                         ):
                             Stack(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FetchProduct(),));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 30, right: 30),
                                      width:double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,

                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xFF040B2D),
                                            blurRadius: 4,
                                            offset: Offset(4, 8), // Shadow position
                                          ),
                                        ],

                                      ),

                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 40, top: 10),
                                            child: Text("Fetch Product",style: GoogleFonts.poppins(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 60,),

                                       CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: new IconButton(
                                              icon: const Icon(Icons.list_alt_outlined,color: Colors.black,size: 45.0),onPressed: null),
                                        ),

                                    ],
                                  ),
                                  const SizedBox(height: 5,),


                                  Container(
                                    margin: const EdgeInsets.only(left: 40,top: 70,right: 40),
                                    width: double.infinity,
                                    height: 110,
                                    child: Text("See all the added products here",style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color:Colors.black87,

                                    ),),
                                  ),

                                  const SizedBox(height: 5,),


                                  Container(
                                    margin: const EdgeInsets.only(left: 40,top: 100,right: 40),
                                    width: double.infinity,
                                    height: 110,
                                    child: Text("Total: $datalength",style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF040B2D)


                                    ),),
                                  ),

                                ],
                              );
                      }if(snapshot.hasError){
                        return const Icon(Icons.error);
                      }
                      return Container();
                      })
                ],
              ),

              const SizedBox(height: 10,),

              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Product-Reviews').snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }
                        if(snapshot.hasData){
                          var reviewlength = snapshot.data!.docs.length;
                          return reviewlength==0?const Center(
                            child: Text("Nothing To Show"),
                          ):
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminReview(),));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30, right: 30),
                                  width:double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,

                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF040B2D),
                                        blurRadius: 4,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],

                                  ),

                                ),
                              ),

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 40, top: 10),
                                        child: Text("Reviews",style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 125,),

                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: new IconButton(
                                        icon: const Icon(Icons.reviews_outlined,color: Colors.black,size: 45.0),onPressed: null),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,),


                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 70,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("See all the reviews here",style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black87,

                                ),),
                              ),

                              const SizedBox(height: 5,),


                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 100,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("Total: $reviewlength ",style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF040B2D)


                                ),),
                              ),


                            ],
                          );
                        }if(snapshot.hasError){
                          return const Icon(Icons.error);
                        }
                        return Container();
                      })
                ],
              ),

              const SizedBox(height: 10,),

              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Check-Out').snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }
                        if(snapshot.hasData){
                          var reviewlength = snapshot.data!.docs.length;
                          return reviewlength==0?const Center(
                            child: Text("Nothing To Show"),
                          ):
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderedPlaced(),));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30, right: 30),
                                  width:double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,

                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF040B2D),
                                        blurRadius: 4,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],

                                  ),

                                ),
                              ),

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 40, top: 10),
                                        child: Text("Orders",style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 125,),

                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: new IconButton(
                                        icon: const Icon(Icons.check,color: Colors.black,size: 45.0),onPressed: null),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,),


                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 70,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("See all the pending Orders here",style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black87,

                                ),),
                              ),

                              const SizedBox(height: 5,),


                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 100,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("Total: $reviewlength ",style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF040B2D)


                                ),),
                              ),


                            ],
                          );
                        }if(snapshot.hasError){
                          return const Icon(Icons.error);
                        }
                        return Container();
                      })
                ],
              ),

              const SizedBox(height: 10,),

              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Check-Out').snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }
                        if(snapshot.hasData){
                          return Container(


                          );


                        }if(snapshot.hasError){
                          return const Icon(Icons.error);
                        }
                        return Container();
                      })
                ],
              ),

              const SizedBox(height: 10,),

              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('userFeedback').snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }
                        if(snapshot.hasData){
                          var feedbacklength = snapshot.data!.docs.length;
                          return feedbacklength==0?const Center(
                            child: Text("Nothing To Show"),
                          ):
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminFeedback(),));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30, right: 30),
                                  width:double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,

                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF040B2D),
                                        blurRadius: 4,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],

                                  ),

                                ),
                              ),

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 40, top: 10),
                                        child: Text("Feedback",style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 100,),

                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        icon: Icon(Icons.feed_outlined,color: Colors.black,size: 45.0),onPressed: null),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,),


                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 70,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("See all the feedbacks here",style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black87,

                                ),),
                              ),

                              const SizedBox(height: 5,),
                              Container(
                                margin: const EdgeInsets.only(left: 40,top: 100,right: 40),
                                width: double.infinity,
                                height: 110,
                                child: Text("Total: $feedbacklength",style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF040B2D)


                                ),),
                              ),



                            ],
                          );
                        }if(snapshot.hasError){
                          return const Icon(Icons.error);
                        }
                        return Container();
                      })
                ],
              ),

              const SizedBox(height: 10,),

              Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      width:double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,

                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF040B2D),
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],

                      ),

                    ),
                  ),

                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 40, top: 10),
                            child: Text("Profile",style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),),
                          )
                        ],
                      ),
                      const SizedBox(width: 135,),

                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: new IconButton(
                            icon: const Icon(Icons.person_2_outlined,color: Colors.black,size: 45.0),onPressed: null),
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),


                  Container(
                    margin: const EdgeInsets.only(left: 40,top: 70,right: 40),
                    width: double.infinity,
                    height: 110,
                    child: Text("See Our Profile ",style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color:Colors.black87,

                    ),),
                  ),

                  const SizedBox(height: 5,),





                ],
              ),







            ],
          ),


        )
    );


  }
}
