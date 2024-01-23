import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestSession extends StatefulWidget {
  const RequestSession({Key? key}) : super(key: key);

  @override
  State<RequestSession> createState() => _RequestSessionState();
}

class _RequestSessionState extends State<RequestSession> {
  late Future<List<Map<String, dynamic>>> _extraSessionData;
  String? _selectedBatch; // Track the selected batch value

  @override
  void initState() {
    super.initState();
    _extraSessionData = getExtraSessionData();
  }

  Future<List<Map<String, dynamic>>> getExtraSessionData() async {
    var response = await http.get(
      Uri.parse('http://10.0.1.243/alpha1/api/batches.php?faculty_id=73'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: _extraSessionData,
            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                List<Map<String, dynamic>> data = snapshot.data!;

                return Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedBatch,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      style: const TextStyle(color: Colors.black),
                      items: data.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item["semester_id"].toString(), // Use a unique identifier for value
                          child: Text(item["batch"].toString()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBatch = newValue;
                        });
                      },
                    ),
                    // Other widgets or UI elements can be added here
                  ],
                );
              }

              if (snapshot.hasError) {
                return Icon(Icons.error);
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
