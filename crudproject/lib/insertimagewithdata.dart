import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class imgupload extends StatefulWidget {
  const imgupload({super.key});

  @override
  State<imgupload> createState() => _imguploadState();
}

class _imguploadState extends State<imgupload> {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController productquantity = TextEditingController();
  String ProductCategory= "Male";
  // Initial Selected Value
  String dropdownvalue = 'Formalwear';
  // File For Image
  File? Profilepic;

// Gettings DownloadUrl From Firebase Storage
  String DownloadUrl = '';

  // Date Upload with Image in Plant Collection using Firebase Firestore

  Future imgup() async{
    UploadTask uploadTask = FirebaseStorage.instance.ref().child("user-data").child(const Uuid().v1()).putFile(Profilepic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    DownloadUrl = await taskSnapshot.ref.getDownloadURL();

  }
  void useradd({String? imgurl})async {
    Map<String, dynamic> useradd = {
      "pname": productname.text.toString(),
      "pcategory": ProductCategory,
      "pdescription": productdescription.text.toString(),
      "pprice": productquantity.text.toString(),
      "pquantity": productprice.text.toString(),
      "ptype": dropdownvalue.toString(),
      "pImage": imgurl,
    };
    await FirebaseFirestore.instance.collection("Product").add(useradd);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Insertion of Data Using Firebase ",),
      ),
      body: Form(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: productname,
              decoration: InputDecoration(
                label: Text("Product Name"),
                hintText: "Please Enter the Product Name",

              ),

            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: productprice,
              decoration: InputDecoration(
                label: Text("Product Price"),
                hintText: "Please Enter Product Price",

              ),
              keyboardType: TextInputType.number,

            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: productdescription,
              decoration: InputDecoration(
                label: Text("Product Description"),
                hintText: "Please Enter Product Description",

              ),
              maxLength: 20,
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: productquantity,
              decoration: InputDecoration(
                label: Text("Product Quantity"),
                hintText: "Please Enter Product Quantity",

              ),
              keyboardType: TextInputType.number,

            ),
            SizedBox(height: 10,),
            DropdownButton<String>(
              value: dropdownvalue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              items: <String>[
                'Formalwear',
                'Hoodies',
                'Jeans',
                'Jumpsuits',
                'T-shirts'
              ]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Please Select the Category"),
            RadioListTile(title: Text('Male'),
                value: 'Male',
                groupValue: ProductCategory,
                onChanged: (String? value) {
                  setState(() {
                    ProductCategory = value!;
                  });
                }),
            RadioListTile(title: Text('Female'),
                value: 'Female',
                groupValue: ProductCategory,
                onChanged: (String? value) {
                  setState(() {
                    ProductCategory = value!;
                  });
                }),
            RadioListTile(title: Text('UniSex'),
                value: 'UniSex',
                groupValue: ProductCategory,
                onChanged: (String? value) {
                  setState(() {
                    ProductCategory = value!;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                XFile? selectedimage = await ImagePicker().pickImage(
                    source: ImageSource.gallery);
                if (selectedimage != null) {
                  File convertedFile = File(selectedimage.path);
                  setState(() {
                    Profilepic = convertedFile;
                  });
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No Image Selected"))
                  );
                }
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: (Profilepic != null)
                    ? FileImage(Profilepic!)
                    : null,
              ),

            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {


            }, child: Text("Upload"))


          ],
        ),
      ),

    );
  }
}
