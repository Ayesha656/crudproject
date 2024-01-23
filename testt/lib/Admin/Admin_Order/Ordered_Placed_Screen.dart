
import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/Admin/Dashboard.dart';
import 'package:uuid/uuid.dart';

class OrderedPlaced extends StatefulWidget {
  // String id;
  // String P_Name;
  // String P_Id;
  // String U_Name;
  // String U_Email;
  // String U_Address;
  // String Status;
  // double T_Amount;
  //
  //
  // OrderedPlaced({required this.id, required this.P_Name, required this.P_Id, required this.U_Name, required this.U_Email,
  //   required this.U_Address, required this.Status , required this.T_Amount});

  @override
  State<OrderedPlaced> createState() => _OrderedPlacedState();
}

class _OrderedPlacedState extends State<OrderedPlaced> {

  // void Accept()async{
  //
  //   String AId = const Uuid().v1();
  //
  //   Map<String, dynamic> productDetail = {
  //     "User-ID": AId,
  //     "Product-ID": widget.id.toString(),
  //     "Product-Name": widget.P_Name.toString(),
  //     "User-name": widget.U_Name.toString(),
  //     "User-email": widget.U_Email.toString(),
  //     "User-address": widget.U_Address.toString(),
  //     "Status" : widget.Status.toString(),
  //     "Total-amount": widget.T_Amount.toString(),
  //
  //   };
  //   FirebaseFirestore.instance.collection("Accept_Order").doc(AId).set(productDetail);
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptScreen(),));
  //
  // }

  
  Future emailsender({String? userEmail})async{
   
    final serviceId = 'service_fp2cyh6';
    final templateId = 'template_jiv9m7k';
    final userId = 'pL_HxMNmOk6CdIaUj';
    final userSubject = 'Laptop Harbor';
    final userMessage = "Your Order are accepted thank you for shopping";

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    var email;
    final response = await http.post(
      url,
      headers:{
        'orgin': 'http://localhost',
        'content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params':{
          'userEmail': 'flutter.eproject@gmail.com',
          'toEmail' : userEmail,
          'userSubject' : userSubject,
          'userMessage' : userMessage,

        }
      })
    );
    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
    }
  }
  
  
  
  
  
  
  


  List<String> _buttonsName = ['Accept Order', 'Reject Order'];
  String _selectedButtonName = 'Accept Order';
  int currentIndex =0;
  int selectedIndex = 0;


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
                        margin: const EdgeInsets.only(left: 30,top: 30),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  const AdminDashbaord()));
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

                const SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      margin: const EdgeInsets.only(top: 30 , left: 100),
                      width: double.infinity,
                      height: 40,
                      child: Text("PENDING ORDERS" , style: GoogleFonts.akatab(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.white
                      ),),
                    ),
                    const SizedBox(height: 20,),
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
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: dataLength,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {

                                  //String adminId = snapshot.data!.docs[index].id;
                                  String id = snapshot.data!.docs[index]['User-ID'];
                                  String pid = snapshot.data!.docs[index]['Product-ID'];
                                  String pname = snapshot.data!.docs[index]['Product-Name'];
                                  String name = snapshot.data!.docs[index]['User-name'];
                                  String email = snapshot.data!.docs[index]['User-email'];
                                  String address = snapshot.data!.docs[index]['User-address'];
                                  String status = snapshot.data!.docs[index]['Status'];
                                  double amount = snapshot.data!.docs[index]['Total-amount'];



                                  return Container(
                                    margin: const EdgeInsets.only(top: 70,left: 8,right: 10),
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
                                          margin: const EdgeInsets.only(left: 20, top: 10),
                                          width: double.infinity ,
                                          height: 200,
                                          child:Text('Product-ID: $pid \n Product-Name: $pname  \n User-Name: $name \n  User-Email: $email \n User-Address: $address \n Status: $status \n Total-Ammount: $amount \n '  , style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),),
                                        ),



                                        const SizedBox(height: 10,),
                                        Column(
                                          children: [



                                            SizedBox(
                                              height: 70,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: _buttonsName.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                                    decoration: BoxDecoration(
                                                      // border: Border.all(width: 2, color: selectedIndex == index ?Color(0xf0008080):
                                                      //   Color(0xffffffff),),
                                                        borderRadius: BorderRadius.circular(15),
                                                        boxShadow: [
                                                          const BoxShadow(
                                                            color: Color(0xFF040B2D),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                            offset: Offset(2, 3),
                                                          )
                                                        ]
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: (){
                                                        emailsender(userEmail: email);


                                                        setState(() {
                                                          selectedIndex = index;
                                                          _selectedButtonName=_buttonsName[index];
                                                          print("$_selectedButtonName");

                                                          FirebaseFirestore.instance.collection("Check-Out").doc(id).update({
                                                              "Status": _selectedButtonName.toString(),
                                                            });

                                                        });

                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all(const Color(0xffffffff),),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(11),
                                                                  side: BorderSide(color: selectedIndex == index ?
                                                                  const Color(0xf0003333) :
                                                                  const Color(0xffffffff),)
                                                              ))
                                                      ),
                                                      child:Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 2, ),
                                                        child: Center(
                                                          child: Text(_buttonsName[index] , style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15,
                                                                color: Colors.black
                                                            ),),

                                                        ),

                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
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

class EmailService {
}
