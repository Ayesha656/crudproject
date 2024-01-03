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
  TextEditingController productcateogry = TextEditingController();



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

            )
          ],
        ),
      ),

    );
  }
}
