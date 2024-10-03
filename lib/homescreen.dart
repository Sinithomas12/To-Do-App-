import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/secondscreen.dart';
import 'package:http/http.dart' as http;

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
            var response = await http.get(url);
            print("Response st:${response.statusCode}");
            print("Response code:${response.body}");
            var data = jsonDecode(response.body);
            String t = data["title"];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SecondS(ti: t),
              ),
            );
          },
          child: Text("go to next"),
          
        ),
      ),
    );
  }
}
