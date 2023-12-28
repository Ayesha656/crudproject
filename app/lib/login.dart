import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
      TextEditingController uname = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 100,
                width: 200,
                child:  Text("Welcome Back!", style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.left,),

              ),
              const SizedBox(
                height: 40,
              ),
              Form(child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
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
                        label:  const Text("Username or Email", style: TextStyle( color: Colors.pink),),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(14)
                        ),
                        prefixIcon: const Icon(Icons.person, color: Colors.black45,),
                      ),
                    ),

                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
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
                          label: const Text("Password", style: TextStyle( color: Colors.pink),),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(14)
                          ),
                          prefixIcon: const Icon(Icons.lock, color: Colors.black45,),
                          suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.black45,)
                      ),
                    ),

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      margin:  const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10),
                      child: Text("Forgot Password?",
                        style: GoogleFonts.montserrat(fontSize: 12,
                            fontWeight: FontWeight.w500, color: Colors.pink),
                        textAlign: TextAlign.right,)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width:double.infinity,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(8),


                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          final username = uname.text;
                          final pwd = password.text;


                          FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: pwd);

                          uname.clear();
                          password.clear();
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=> login()));
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

