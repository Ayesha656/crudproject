import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testt/Admin/Firebase_Firestore/product_Fetch.dart';
import 'package:uuid/uuid.dart';

import '../Dashboard.dart';

class insertScreen extends StatefulWidget {
  const insertScreen({super.key});

  @override
  State<insertScreen> createState() => _insertScreenState();
}

class _insertScreenState extends State<insertScreen> {

  TextEditingController Name=TextEditingController();
  TextEditingController Brand=TextEditingController();
  TextEditingController Price=TextEditingController();
  TextEditingController Memory=TextEditingController();
  TextEditingController operatingSystem=TextEditingController();
  TextEditingController Processor=TextEditingController();
  TextEditingController Display=TextEditingController();
  TextEditingController powerSupply=TextEditingController();
  TextEditingController Battery=TextEditingController();
  TextEditingController Storage=TextEditingController();

  File? productImage;

  void InsertProductwithImg()async{

    UploadTask uploadTask = FirebaseStorage.instance.ref().child("Product-Images").child(const Uuid().v1()).putFile(productImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String Image = await taskSnapshot.ref.getDownloadURL();
    InsertProduct(imgURL: Image);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const FetchProduct(),));

  }

  void InsertProduct ({String? imgURL})async{

    String productId = const Uuid().v1();

    Map<String , dynamic> productDetails ={
      "Product-Id":productId,
      "Product-Image": imgURL,
      "Product-Name":Name.text.toString(),
      "Product-Brand":Brand.text.toString(),
      "Product-Price":int.parse(Price.text),
      "Product-Memory":Memory.text.toString(),
      "Product-operatingSystem":operatingSystem.text.toString(),
      "Product-Processor":Processor.text.toString(),
      "Product-Display":Display.text.toString(),
      "Product-powerSupply":powerSupply.text.toString(),
      "Product-Battery":Battery.text.toString(),
      "Product-Storage":Storage.text.toString(),

    };

    FirebaseFirestore.instance.collection("Product-Data").doc(productId).set(productDetails);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const FetchProduct(),));

  }
  var _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    Name.dispose();
    Brand.dispose();
    Price.dispose();
    Memory.dispose();
    operatingSystem.dispose();
    Processor.dispose();
    Display.dispose();
    powerSupply.dispose();
    Battery.dispose();
    Storage.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      margin: const EdgeInsets.only(top: 30 , left: 130),
                      width: double.infinity,
                      height: 40,
                      child: Text("Insert Products" , style: GoogleFonts.akatab(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.white
                      ),),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                              children: [
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only( top: 110),
                                    width: 350,
                                    height: 800,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xFF040B2D),
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4,
                                          offset: Offset(9, 8), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formkey,
                                  child: Column(
                                    children: [

                                      const SizedBox(height: 20,),

                                      Stack(
                                        children: [
                                         GestureDetector(
                                          onTap: () async {
                                            XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            if (selectedImage!=null) {
                                              File convertedFile  =File(selectedImage.path);
                                              setState(() {
                                                productImage = convertedFile;
                                              });
                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Image Selected")));
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.grey.shade400,
                                            backgroundImage: productImage!=null?FileImage(productImage!):null,
                                          ),
                                        ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 35,height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.purple.withOpacity(0.1)
                                              ),
                                              child: const Icon(Icons.add,color: Colors.black,size: 35,),
                                            ),
                                          ),
                                        ],

                                      ),

                                      const SizedBox(height: 20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Name,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "ProductName is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Product name"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height: 20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Brand,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "Brand Name is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Brand name"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height: 20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Price,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "price is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Price"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Memory,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "Memory is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Laptop's Memory"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: operatingSystem,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "Operating System is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Operating System"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Processor,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "Processor is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Processor "),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Display,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return " Display is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Display"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),
                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: powerSupply,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return " Power Supply  is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Power Supply"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),
                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Battery,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return " Battery is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Battery"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          margin: const EdgeInsets.symmetric(horizontal:20),
                                          child:TextFormField(
                                              controller: Storage,
                                              validator: (value){
                                                if (value==null || value.isEmpty || value==" ") {
                                                  return "Storage is required ";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Enter Storage"),
                                                border: OutlineInputBorder(

                                                  borderSide: BorderSide(
                                                      color: Colors.lime
                                                  ),
                                                ),
                                                prefixIcon: Icon(Icons.person),
                                              )
                                          )
                                      ),

                                      const SizedBox(height:20,),

                                      ElevatedButton(onPressed: (){

                                        if (_formkey.currentState!.validate()) {

                                          InsertProductwithImg();

                                        }

                                      },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(const Color(0xffffffff)),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 20,left: 30,right: 30),
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xf0000523),
                                            border: Border.all(color: const Color(0xffffffff),width: 3),
                                            borderRadius: BorderRadius.circular(10),

                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4,vertical:1 ),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 120,),
                                                Text("Insert", style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color:  const Color(0xffffffff)
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30,),

                                    ],
                                  ),
                                ),





                              ]
                          ),
                        ]


                    ),
                  ],
                ),

              ],

            )
          ],


        ),









            )

        );




  }
}
