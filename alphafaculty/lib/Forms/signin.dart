import 'dart:convert';

import 'package:alphafaculty/dashboard_screens/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SigInScreen extends StatefulWidget {
  const SigInScreen({super.key});

  @override
  State<SigInScreen> createState() => _SigInScreenState();
}

class _SigInScreenState extends State<SigInScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool userLoader = false;

  Future userGet()async{

    setState(() {
      userLoader = !userLoader;
    });
    // Ensure that username and password are not null
    if (username.text == null || password.text == null) {
      // Handle the case where username or password is null
      print("username or password is null");
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "GET",
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IkJtSzdBd1kxYjB3N0R3WFlKamlzcGc9PSIsInZhbHVlIjoiSDRTVGx2VjUyYU9pTkR6Q2YzcVRwaWpTVDlibzJ4elRSTjZ0NHA0OWVIMDN2MnJnakpXRytuRkdhbjY1ZnZ6NktqUmpWWjQza2x5TFRKc0tXV3ZCN0hSWWZ2MkJiaEM1R1VLeit4ellMVkpGdjQ3ODUyYzFuYUNKRGN2Sm96SjgiLCJtYWMiOiIzYjA5MTMwMjY4ZDI4Yjk2OGM0OWFkOTE4OGZjMmY2Yjc0OWYzNDkzNGY1YTk0N2NmZGM1Mzc5ZDliNDA5ZDZhIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1OMjZabGcvaVIwd3JhM0U1ell6YkE9PSIsInZhbHVlIjoiZC9ycThHc1RZQlZIeU9ndS9QRkhYZi9PeEcvbnM2Kys1eU9QNFBjRjZ6QUZrMVExV0hYUnRrUXd3NEFRQy8xa2dSM3BMVlB6VFZNb1d2bThoOVBSYUdwYVhVODlqWlI0amFNWUFaY3Bjak54THlyaENIN2tmZXFoaWxWUFgvMEoiLCJtYWMiOiIyMmE4OTc2ZjQ2ZWVmYWUwYmM4NjgxZGE2ODU0NmU4NTdkOWQwMGNjZTNiNzczODczYzg3M2Y4YzQwZTY3ZGYyIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('GET', Uri.parse('http://10.0.1.243/alpha1/api/login.php?role=Faculty&email=${username.text}&password=${password.text}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      debugPrint(res);
      Map map = jsonDecode(res);
     String status = map["status"];

    String facultyname= map["obj"]["name"];
    String facultyemail = map["obj"]["email"];
    String facultypassword = map["obj"]["password"];

      debugPrint("status from api:$status");
    debugPrint(facultyname);
     debugPrint("Your Status is: $status");
      if(status == "success"){
        debugPrint(res);

        if(context.mounted){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHome(studentID: studentId.text.toString(),),));
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen(facultyname: facultyname,facultypass: facultypassword,)));
        }
        setState(() {
          userLoader = !userLoader;
        });
      }
      else{
        debugPrint(res);
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
        }
      }
      setState(() {
        userLoader = !userLoader;
      });
    }
    else {
      setState(() {
        userLoader = !userLoader;
      });
      var resError = response.reasonPhrase;
      debugPrint(resError);
    }
  }

   void loginStudent()async{
     SharedPreferences usernamelog = await SharedPreferences.getInstance();
     //studentLog.setString(username);
     usernamelog.setString("email", username.text);
     if(context.mounted){
       //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHome(studentID: studentId.text.toString(),),));
       Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen(facultyname: username.text, facultypass: password.text)));
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                  image:
                  DecorationImage(image: AssetImage("images/usericon.png"))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Welcome Faculty! ",
              style:
              GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(7)
                        ],
                        maxLength: 8,
                        controller: username,
                        keyboardType: TextInputType.text,
                        onChanged: (val){
                          if(val.length==7){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text("Enter User Name"),
                            hintText: "abc***",
                            focusColor: Colors.amber,
                            labelStyle: const TextStyle(color: Colors.amber),
                            fillColor: Colors.amber,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value){
                          if(value==null || value.isEmpty || value == " "){
                            return "Username is required!";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10)
                        ],
                        maxLength: 10,

                        controller: password,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            label: const Text("Enter Password"),
                            hintText: "***",
                            focusColor: Colors.amber,
                            labelStyle: const TextStyle(color: Colors.amber),
                            fillColor: Colors.amber,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value){
                          if(value==null || value.isEmpty || value == " "){
                            return "Password is required";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 6,),

                      const SizedBox(height: 40,),
                      // Text("Forgot Password?", style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold),),
                      // SizedBox(height: 40,),
                      Container(
                        width: double.infinity,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              userGet();
                              loginStudent();
                              debugPrint(username.text);
                              debugPrint(password.text);
                            }
                          },
                          // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                          style: ElevatedButton.styleFrom(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            backgroundColor: Colors.amber,
                            textStyle: const TextStyle(color: Colors.white),

                          ),
                          child: userLoader==false?const Text("Login"):const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                            child: CircularProgressIndicator(color: Colors.white,),
                          ),


                        ),
                      ),

                    ],
                  )),
            )
          ],
        ),
      ),

    );
  }
}