import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/Admin/Firebase_Firestore/product_Update_Screen.dart';

import 'Product_Insert_Screen.dart';

class FetchProduct extends StatefulWidget {
  const FetchProduct({super.key});

  @override
  State<FetchProduct> createState() => _FetchProductState();
}

class _FetchProductState extends State<FetchProduct> {

  List<String> _buttons = ['assets/images/logo_hp.jpg', 'assets/images/logo_alien.png',
    'assets/images/logo_asus.png', 'assets/images/logo_lenovo.png', 'assets/images/logo_dell.jpg'];
  String _selectedButton = '';
  int currentIndex =0;
  int selectedIndex = 0;

  List<String> _buttonsName = ['HP', 'ALIEN WARE', 'ASUS', 'LENOVO', 'DELL'];
  String _selectedButtonName = 'HP';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.only(left: 5, right: 5,top: 6),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(image:NetworkImage("https://www.cjpl.in/wp-content/uploads/2021/06/Laptop_banner.jpg"),
                      fit: BoxFit.cover),
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(10),

                  boxShadow:  [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(4, 10,), // Shadow position
                    ),
                  ]

              ),
            ),

            SizedBox(height: 50,),

            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _buttons.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 2, color: selectedIndex == index ?Color(0xf0008080):
                      //   Color(0xffffffff),),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: selectedIndex == index ?Color(0xf0b0fafa):
                            Color(0xffffffff),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(2, 3),
                          )
                        ]
                    ),
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          selectedIndex = index;
                          _selectedButton=_buttons[index];
                          _selectedButtonName=_buttonsName[index];
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xffffffff),),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  side: BorderSide(color: selectedIndex == index ?
                                  Color(0xFF040B2D) :
                                  Color(0xffffffff),)
                              ))
                      ),
                      child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2, ),
                          child:
                          Container(
                            width: 80,
                            height: 180,
                            // color: Colors.cyan,
                            child: Image.asset(_buttons[index]),
                          )
                        // Text(_buttons[index], style: GoogleFonts.poppins(
                        //   fontWeight: FontWeight.w500,
                        //   color: selectedIndex == index ? Color(0xffffffff) :
                        //   Color(0xf0000000),
                        // ),)
                      ),
                    ),
                  );
                },
              ),
            ),

            Center(
              child: Column(
                children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> insertScreen()));
                      },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(left: 40, top: 10),
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Colors.black,
                                Color(0xFF040B2D),
                                Colors.black
                              ]
                          ),
                        borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(13, 10), // Shadow position
                            ),
                          ]
                      ),
                      child: Text("Add Product", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),),

                    ),
                  )
                ],
              )
            ),



            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Product-Data").where('Product-Brand',isEqualTo: _selectedButtonName)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    var dataLength = snapshot.data!.docs.length;
                    return dataLength==0?Text("Nothing to Show"):
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: dataLength,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {

                        String adminId = snapshot.data!.docs[index].id;
                        String image = snapshot.data!.docs[index]['Product-Image'];
                        String productname = snapshot.data!.docs[index]['Product-Name'];
                        String brand = snapshot.data!.docs[index]['Product-Brand'];
                        num price = snapshot.data!.docs[index]['Product-Price'];
                        String memory = snapshot.data!.docs[index]['Product-Memory'];
                        String osystem = snapshot.data!.docs[index]['Product-operatingSystem'];
                        String processor = snapshot.data!.docs[index]['Product-Processor'];
                        String display = snapshot.data!.docs[index]['Product-Display'];
                        String powersupply = snapshot.data!.docs[index]['Product-powerSupply'];
                        String battery = snapshot.data!.docs[index]['Product-Battery'];
                        String storage = snapshot.data!.docs[index]['Product-Storage'];

                        return Container(
                          margin: const EdgeInsets.only(top: 30),
                          width: double.infinity,
                          height: 300,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(image),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Center(
                                child: Text(productname, style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),),
                              ),
                              const SizedBox(height: 5,),
                              Center(
                                child: Text('Brand: $brand', style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),),
                              ),

                              const SizedBox(height: 5,),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 140),
                                    width: 250,
                                    height: 40,
                                    child: Text('Price: $price', style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    ),),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  productupdate(
                                        pid: adminId,
                                        pimage: image,
                                        pname: productname,
                                        pbrand: brand,
                                        pprice: price ,
                                        pmemory: memory,
                                        pos: osystem,
                                        pprocessor: processor,
                                        pdisplay: display,
                                        ppowersupply: powersupply,
                                        pbattery: battery,
                                        pstorage: storage,),));

                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 90,
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
                                      child: Text("Update" , style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black
                                      ),),
                                    ),
                                  ),

                                  const SizedBox(width: 5,),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {

                                          showDialog(context: context, builder: (context){
                                            return AlertDialog(
                                              title: const Text("Specification"),
                                              content:  Text('01: Memory $memory \n'
                                                  '02: Operating System $osystem \n'
                                                  '03: Processor $processor \n'
                                                  '04: Display System $display \n'
                                                  '05: Power Supply: $powersupply \n'
                                                  '06: Battery $battery \n'
                                                  '07: Storage $storage ', style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF040B2D),
                                              ),

                                              ),
                                              actions: [
                                                ElevatedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: const Text("Ok")),
                                              ],
                                            );
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10, top: 5),
                                          margin: const EdgeInsets.only(left: 10),
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 4,
                                                  offset: Offset(13, 10),// Shadow position
                                                ),
                                              ]
                                          ),
                                          child: Text("Specification" , style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black
                                          ),),
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(width: 5,),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance.collection("Product-Data").doc("Product-Id").delete();
                                          FirebaseStorage.instance.refFromURL(image).delete();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => FetchProduct(),));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10, top: 5),
                                          margin: const EdgeInsets.only(left: 10),
                                          width: 80,
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
                                          child: Text("Delete" , style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black
                                          ),),
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
                  }if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  }
                  return Container();
                }),
            const SizedBox(height: 20,),






          ],
        ),
      ),



    );

  }
}
