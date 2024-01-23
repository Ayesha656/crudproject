import "package:alphafaculty/dashboard_screens/current_batches.dart";
import "package:alphafaculty/dashboard_screens/fetch_checkin.dart";
import "package:alphafaculty/dashboard_screens/request_session.dart";
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import 'package:http/http.dart' as http;
import "dart:convert";
import "package:achievement_view/achievement_view.dart";

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key, required this.facultyname, required this.facultypass, required this.fa_id});
final String facultyname ;

  final String facultypass;
  final String fa_id;

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  String _scanBarcode = 'Unknown';

  Future markAttendance()async{
    var headers = {
      'Content-Type': 'multipart/form-data'
    };
    var request = http.Request('GET', Uri.parse('http://10.0.1.243/alpha1/api/mark.php?role=Faculty&email=${widget.facultyname}&password=${widget.facultypass}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      debugPrint(res);
      Map map = jsonDecode(res);
      String apiRes = map['status'];
      print(apiRes);


      if(context.mounted){
        if(apiRes=="Check In"){
          AchievementView(
              elevation: 0,
              color: Colors.green,
              textStyleTitle: const TextStyle(
                  color: Colors.white
              ),
              textStyleSubTitle: const TextStyle(
                  color: Colors.white
              ),
              icon: const Icon(Icons.check_circle, color: Colors.white,),
              title: "Check In",
              subTitle: "You have successfully checked-In!"
          ).show(context);
        }
        if(apiRes=="Invalid Slot"){
          AchievementView(
              elevation: 0,
              color: Colors.red,
              textStyleTitle: const TextStyle(
                  color: Colors.white
              ),
              textStyleSubTitle: const TextStyle(
                  color: Colors.white
              ),
              icon: const Icon(Icons.calendar_month, color: Colors.white,),
              title: "Check In Not Marked",
              subTitle: "Day not matched"
          ).show(context);
        }
        if(apiRes=="Invalid Time Slot"){
          AchievementView(
              elevation: 0,
              color: Colors.red,
              textStyleTitle: const TextStyle(
                  color: Colors.white
              ),
              textStyleSubTitle: const TextStyle(
                  color: Colors.white
              ),
              icon: const Icon(Icons.timer, color: Colors.white,),
              title: "Check In Not Marked",
              subTitle: "Time Slot not matched"
          ).show(context);
        }
        if(apiRes=="Already Marked"){
          AchievementView(
              elevation: 0,
              color: const Color(0xFFf5bf53),
              textStyleTitle: const TextStyle(
                  color: Colors.white
              ),
              textStyleSubTitle: const TextStyle(
                  color: Colors.white
              ),
              icon: const Icon(Icons.timer, color: Colors.white,),
              title: "Check In Already Marked",
              subTitle: "No Need to mark again"
          ).show(context);
        }
      }
      return res;
    }
    else {
      debugPrint(response.reasonPhrase);
    }
  }


  Future<void> scanqr() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    if(_scanBarcode == "http://10.0.1.243/alpha1/api/mark.php"){
      markAttendance();
    }
    if(_scanBarcode != "http://10.0.1.243/alpha1/api/mark.php"){
      AchievementView(
          elevation: 0,
          color: Colors.red,
          textStyleTitle: const TextStyle(
              color: Colors.white
          ),
          textStyleSubTitle: const TextStyle(
              color: Colors.white
          ),
          icon: const Icon(Icons.qr_code, color: Colors.white,),
          title: "Attendance Not Marked",
          subTitle: "QR Code is Not Matched"
      ).show(context);
    }
    if(_scanBarcode == "-1"){
      AchievementView(
          elevation: 0,
          color: Colors.red,
          textStyleTitle: const TextStyle(
              color: Colors.white
          ),
          textStyleSubTitle: const TextStyle(
              color: Colors.white
          ),
          icon: const Icon(Icons.qr_code, color: Colors.white,),
          title: "QR Code",
          subTitle: "QR Code is Not Found"
      ).show(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics( ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage("images/logo.png", ))
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar.png"),
                    backgroundColor: Colors.white,
                    radius: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Miss Syeda Ayesha Nusrat", style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),),
                  // SizedBox(height: 4,),
                  Text("ayeshanusrat12@gmail.com", style: GoogleFonts.roboto(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),),
                  SizedBox(
                    height: 10,
                  ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage("images/qr.png"))),
                            child: GestureDetector(
                              onTap: scanqr
                            )),
                        Text("Scan QR Code", style: GoogleFonts.roboto(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ),
                )
                ],
              ),
            ),

            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
              ),
              child: ListTile(
                leading: Icon(Icons.qr_code),
                title: Text("Fetch Check-Ins", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("Fetch All Your Check-Ins", style: GoogleFonts.roboto(color: Colors.black),),
                onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> Checkin()));
                },


              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text("Current Batches", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("Your Current Batches", style: GoogleFonts.roboto(color: Colors.black),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> current_batches(facultyid: fa_id,)));
                },
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                  vertical: 10
              ),
              child: ListTile(

                leading: Icon(Icons.ac_unit),
                title: Text("Request Session", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("Enter Total Sessions Required!", style: GoogleFonts.roboto(color: Colors.black),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RequestSession()));
                },

              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                  vertical: 10
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Alternates", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("Fetch All Your Alternates", style: GoogleFonts.roboto(color: Colors.black),),

              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                  vertical: 10
              ),
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text("E-Projects", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("Check Current Months E-Project Data", style: GoogleFonts.roboto(color: Colors.black),),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                  vertical: 10
              ),
              child: ListTile(
                leading: Icon(Icons.event),
                title: Text("Events", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),),
                subtitle: Text("See All Events!", style: GoogleFonts.roboto(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
