import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {

  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController productquantity = TextEditingController();
  String ProductCategory= "Male";
  // Initial Selected Value
  String dropdownvalue = 'Formalwear';

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
              items: <String>['Formalwear', 'Hoodies', 'Jeans', 'Jumpsuits','T-shirts']
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
            RadioListTile( title: Text('Male'),value: 'Male', groupValue: ProductCategory, onChanged: (String? value){
              setState(() {
                ProductCategory = value!;

              });
            }),
            RadioListTile(title: Text('Female'), value: 'Female', groupValue: ProductCategory, onChanged: (String? value){
              setState(() {
                ProductCategory = value!;

              });
            }),
            RadioListTile(title: Text('UniSex'), value: 'UniSex', groupValue: ProductCategory, onChanged: (String? value){
              setState(() {
                ProductCategory = value!;

              });
            }),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(onPressed: (){

              Map<String, dynamic> productadd = {
                "pname": productname.text.toString(),
                "pcategory": ProductCategory,
                "pdescription": productdescription.text.toString(),
                "pprice": productquantity.text.toString(),
                "pquantity": productprice.text.toString(),
                "ptype": dropdownvalue.toString(),

              };
              FirebaseFirestore.instance.collection("Product").add(productadd);


            }, child: Text("Upload"))


          ],
        ),
      ),

    );
  }
}
