import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class signup2 extends StatefulWidget {
  const signup2({super.key});

  @override
  State<signup2> createState() => _signup2State();
}

class _signup2State extends State<signup2> {
  @override
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conf_password = TextEditingController();
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
  void showAchievementView2(){
    AchievementView(
      title: "Sorry!",
      subTitle: "Password Not Matched!",
      //content: Widget()

      icon: Icon(Icons.error, color: Colors.white,),
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,  borderRadius: BorderRadius.circular(5),
      color: Colors.red,


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
                        controller: conf_password,
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
                                  final cpass = conf_password.text;

                                  if(pwd == cpass ){
                                  showAchievementView();
                                  uname.clear();
                                  password.clear();
                                     conf_password.clear();
                                      }
                                      else{
                                      showAchievementView2();

                                      password.clear();
                                      conf_password.clear();
                                      }

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
