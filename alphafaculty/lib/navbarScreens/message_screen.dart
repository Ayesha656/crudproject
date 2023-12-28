import 'package:flutter/material.dart';

import '../resuable_widgets.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userMessage = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Form(
          key: formkey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 14,top: 20),
                  child: const Text("Leave A Message",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),
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
                  child: const Text("Drop us your short message our team will resolve your query within sometime and let you know",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),)),

              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ReusableTextFormField(
                  controller: userName,
                  hinttext: "John Doe",
                  label: "Your Name",
                  mainError: "Name is Required",
                  keyboardtype: TextInputType.text,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ReusableTextFormField(
                  controller: userEmail,
                  hinttext: "johndoe@gmail.com",
                  label: "Email",
                  mainError: "Email is Required",
                  keyboardtype: TextInputType.text,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ReusableTextFormField(
                  controller: userMessage,
                  label: '',
                  hinttext: "Type Your Message Here",
                  mainError: "Message is Required",
                  keyboardtype: TextInputType.text,
                  maxlines: 10,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Name: ${userName.text} & Email: ${userEmail.text} & Message: ${userMessage.text}")));
                      userName.clear();
                      userEmail.clear();
                      userMessage.clear();
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
                  child: const Text("Message Us"),


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

