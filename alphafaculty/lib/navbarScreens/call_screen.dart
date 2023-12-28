import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  List ourNumbersName = ["Telephone 1", "Telephone 2", "Telephone 3"];
  List ourNumbers = ["+92 3112146687","+92 3112146687","+92 3112146687"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 14,top: 20),
              child: const Text("Having Query?",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),

          Container(
            margin: const EdgeInsets.only(left: 14.5),
            width: 40,
            child: const Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 14,top: 10),
              child: const Text("We are here to answer all your queries from taking admission to getting certified.",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 14),)),

          Container(
              margin: const EdgeInsets.only(left: 14,top: 20),
              child: const Text("Phone Numbers",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)),
          Container(
            margin: const EdgeInsets.only(left: 14.5),
            width: 40,
            child: const Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),

          ListView.builder(
            itemCount: ourNumbersName.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(4, 4)
                    )
                  ]
              ),
              child: GestureDetector(
                onTap: (){
                        try{
                          url_launcher.launch("tel://${ourNumbers[index]}");
                        }
                        catch(ex){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));
                        }
                },
                child: ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.phone),
                  title: Text("${ourNumbersName[index]}"),
                  subtitle: Text("${ourNumbers[index]}"),
                ),
              ),
            );
          },),

          const SizedBox(height: 20,),

          Container(
            width: double.infinity,
            height: 90,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(
              child: ListTile(
                leading: Icon(Icons.warning_amber),
                title: Text("Note"),
                subtitle: Text("All the above Numbers are only functional in office working hours (9-5)"),
              ),
            ),
          ),
        ],
      ),




    );
  }
}
