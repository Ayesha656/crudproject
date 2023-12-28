import 'package:achievement_view/achievement_widget.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:achievement_view/achievement_view.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();

  void showAchievementView(){
    AchievementView(
        title: "Yeaaah!",
        subTitle: "User Registered!",
        //content: Widget()

        icon: Icon(Icons.insert_emoticon, color: Colors.white,),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,  borderRadius: BorderRadius.circular(5),
        color: Colors.green,


    ).show(context);
  }


  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child:  Text("Welcome Back!", style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.left,),

                ),
                SizedBox(
                  height: 40,
                ),
                Form(child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black26,
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value == null|| value.isEmpty || value== " " ){
                            return " please fill the feilds";
                          }
                        },
                        controller: uname,
                        decoration: InputDecoration(
                          hintText: "Username or Email",
                          label: Text("Username or Email", style: TextStyle( color: Colors.pink),),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(14)
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.black45,),
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black26,
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value == null|| value.isEmpty || value== " " ){
                            return " please fill the feilds";
                          }
                        },
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "Password",
                          label: Text("Password", style: TextStyle( color: Colors.pink),),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(14)
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.black45,),
                          suffixIcon: Icon(Icons.remove_red_eye, color: Colors.black45,)
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                        margin:  EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10),
                        child: Text("Forgot Password?",
                          style: GoogleFonts.montserrat(fontSize: 12,
                              fontWeight: FontWeight.w500, color: Colors.pink),
                          textAlign: TextAlign.right,)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width:double.infinity,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(8),


                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            final username = uname.text;
                            final pwd = password.text;


                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: pwd);
                            showAchievementView();
                            uname.clear();
                            password.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> login()));
                          },
                          child: Text("Sign Up", style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.normal, color: Colors.white),textAlign: TextAlign.center,),
                        ),
                      ),

                    )

                  ],))
              ],
            ),
          ),

      ),
    );
  }
}
