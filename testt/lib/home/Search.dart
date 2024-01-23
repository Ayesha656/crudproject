import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testt/home/Description_Screen.dart';

import '../Bottom_Navigation.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  var searchName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only( left:10,right:10,top: 55),
          child: TextField(
            textAlign: TextAlign.center,
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchName = value;
              });
            },
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xf0000000)),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Color(0xf0000000)),
              contentPadding: const EdgeInsets.only(left: 20, top: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xf0003333)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xf0003333)),
              ),
              suffixIcon: IconButton(
                onPressed: () {
// perform search
                },
                icon: const Icon(
                  Icons.search,
                  color: Color(0xf0000000),
                ),
              ),
            ),
            cursorColor: const Color(0xf0000000),
          ),
        ),

        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const bottomNavigation()));
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xf0000000),
              ));
        }),
// dehaze
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: const EdgeInsets.only(top: 20,bottom: 10,left: 20),
                child: Text("Top Searches",style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),),
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Product-Data')
                      .orderBy('Product-Brand')
                      .startAt([searchName.toUpperCase()]).endAt([searchName.toUpperCase() + "\uf8ff"]).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          String id = snapshot.data!.docs[index]['Product-Id'];
                          String name = snapshot.data!.docs[index]['Product-Name'];
                          String brand = snapshot.data!.docs[index]['Product-Brand'];
                          String img = snapshot.data!.docs[index]['Product-Image'];
                          num price = snapshot.data!.docs[index]['Product-Price'];
                          String battery = snapshot.data!.docs[index]['Product-Battery'];
                          String display = snapshot.data!.docs[index]['Product-Display'];
                          String memory = snapshot.data!.docs[index]['Product-Memory'];
                          String processor = snapshot.data!.docs[index]['Product-Processor'];
                          String storage = snapshot.data!.docs[index]['Product-Storage'];
                          String os = snapshot.data!.docs[index]['Product-operatingSystem'];
                          String power = snapshot.data!.docs[index]['Product-powerSupply'];

                          return ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionScreen(id: id, image: img, name: name, brand: brand, price: price, battery: battery, display: display, memory: memory, processor: processor, storage: storage, operatingSystem: os, power: power)));

                            },
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(img),
                            ),
                            title: Text(name),
                            subtitle: Text("\$$price"),
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

