import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/Firebase_Auth/Login_Screen.dart';

class updatepassword extends StatefulWidget {
  const updatepassword({super.key});

  @override
  State<updatepassword> createState() => _updatepasswordState();
}

class _updatepasswordState extends State<updatepassword> {
  TextEditingController password = TextEditingController();
  bool passHide = true;

  var _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    password.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 600,
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/forgot-password.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(6, 27, 28,1),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)) ),
                  width: double.infinity,
                  height: 600,
                  child:   Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20 , top: 20),
                        width: double.infinity,
                        child: Center(
                          child: Text("Forgott Password" , style: GoogleFonts.abyssinicaSil(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          ),),
                        ),
                      ),

                      Column(
                        children: [
                          Stack(
                              children:[
                                Container(
                                  width: 300,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Form(
                                    key: _formkey,

                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(

                                            controller: password,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Password is required";
                                              }
                                            },
                                            obscureText: passHide==true?true:false,
                                            obscuringCharacter: "*",
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Password",
                                              suffixIcon: IconButton(onPressed: (){
                                                setState(() {
                                                  passHide =! passHide;
                                                });
                                              }, icon: passHide==true? Icon(Icons.remove_red_eye):Icon(Icons.key)),
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.password,color: Color.fromRGBO(6, 27, 28,1),),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: (){
                                          if(_formkey.currentState!.validate()){

                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                                   child: const Text("Login");
                                          }
                                        }, child: Container(
                                      margin: EdgeInsets.only(left: 50 , top: 80),
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Color.fromRGBO(6, 27, 28,1),
                                                Colors.black
                                              ]
                                          )
                                      ),
                                      child: const Center(
                                        child: Text("Update Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20), ),
                                      ),
                                    )
                                    )
                                  ],
                                )
                              ]
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
