import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './basicwidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "To-Do List",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(240, 211, 216, 214),
                  Color.fromARGB(255, 230, 236, 239),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: const MyWidget(), // Here, MyWidget is placed inside the body
      ),
    );
  }
}



   