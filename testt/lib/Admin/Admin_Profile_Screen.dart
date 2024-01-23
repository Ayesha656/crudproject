import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FeedBack_Screen.dart';
import '../Firebase_Auth/Login_Screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Future getUser()async{
    SharedPreferences userEmail = await SharedPreferences.getInstance();
    return userEmail.getString("User-Email");
  }
  String uEmail = '';
  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child:
          SafeArea(
            top: true,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),

              child: Column(
                children: [
                  SizedBox(height: 15,),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("userData").where('User-Email',isEqualTo: uEmail).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {

                          var dataLength = snapshot.data!.docs.length;

                          return dataLength==0?Center(
                            child: Text("Nothing to Show"),
                          ):ListView.builder(
                            itemCount: dataLength,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String userID = snapshot.data!.docs[index]['User-Id'];
                              String userName = snapshot.data!.docs[index]['User-Name'];
                              String userImage = snapshot.data!.docs[index]['User-Image'];
                              String userEmail = snapshot.data!.docs[index]['User-Email'];
                              String userLastname = snapshot.data!.docs[index]['User-LName'];
                              String userContact = snapshot.data!.docs[index]['User-Contact'];
                              String userPassword = snapshot.data!.docs[index]['User-Password'];

                              return GestureDetector(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(userID: userID, userName: User-Name, userEmail: userEmail,userImage: userImage),));
                                },
                                onDoubleTap: ()async{
                                  showDialog<void>(
                                    context: context,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: Text('Delete User'),
                                        content: Text('Are you sure you want to delete $userName'),
                                        actions: <Widget>[
                                          TextButton(onPressed: (){
                                            Navigator.of(dialogContext)
                                                .pop();
                                          }, child: Text("Cancel")),
                                          ElevatedButton(
                                              child: Text('Delete',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                                              onPressed: () async{
                                                await FirebaseFirestore.instance.collection("userData").doc(userID).delete();
                                                await FirebaseStorage.instance.refFromURL(userImage).delete();
                                                Navigator.of(dialogContext)
                                                    .pop(); // Dismiss alert dialog
                                              },
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600)
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10,top: 20),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [

                                          SizedBox(
                                            width: 200, height: 200,

                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(150),

                                                child: Image(image: NetworkImage('$userImage'))
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 35,height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.purple.withOpacity(0.1)
                                              ),
                                              child: Icon(Icons.edit,color: Colors.black,size: 20,),
                                            ),
                                          ),


                                        ],
                                      ),


                                      SizedBox(height: 20,),
                                      Text('$userName',style:GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600
                                      ),),

                                      SizedBox(height: 20,),


                                      SizedBox(height: 30,),
                                      const Divider(),


                                      SizedBox(height: 10,),

                                      //MENU SECTION//

                                      ListTile(
                                        leading: Container(
                                          width: 40,height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.settings,color: Colors.black,),
                                        ),
                                        title: Text("Settings",style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),),
                                        trailing:Container(
                                          width: 30,height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.arrow_right_alt,color: Colors.black,),
                                        ),
                                      ),

                                      SizedBox(height: 10,),

                                      ListTile(
                                        leading: Container(
                                          width: 40,height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.monetization_on_outlined,color: Colors.black,),
                                        ),
                                        title: Text("Billing Details",style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),),
                                        trailing:Container(
                                          width: 30,height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.arrow_right_alt,color: Colors.black,),
                                        ),
                                      ),


                                      SizedBox(height: 10,),

                                      ListTile(
                                        leading: Container(
                                          width: 40,height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.rate_review_sharp,color: Colors.black,),
                                        ),
                                        title: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                                          },
                                          child: Text("FeedBack",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          ),),
                                        ),
                                        trailing:Container(
                                          width: 30,height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.arrow_right_alt,color: Colors.black,),
                                        ),

                                      ),
                                      SizedBox(height: 30,),
                                      const Divider(),

                                      SizedBox(height: 10,),
                                      ListTile(
                                        leading: Container(
                                          width: 40,height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.logout,color: Colors.redAccent,),
                                        ),
                                        title: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                          },
                                          child: Text("LogOut",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          ),),
                                        ),
                                        trailing:Container(
                                          width: 30,height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black.withOpacity(0.1)
                                          ),
                                          child: const Icon(Icons.arrow_right_alt,color: Colors.black,),
                                        ),

                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },);
                        }
                        if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        }
                        return Container();
                      })  ,

                  SizedBox(height: 20,),


                ],
              ),
            ),
          ),



        )
    );
  }
}
