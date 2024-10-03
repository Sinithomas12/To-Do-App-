import 'package:flutter/material.dart';
import 'homescreen.dart'; // Adjust the import path if needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreens(),
    );
  }
}
