import 'package:flutter/material.dart';

class SecondS extends StatelessWidget {
  String ti; // Make this field final
  SecondS({super.key, required this.ti}); // Pass ti in the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ti), // Use the ti variable to display the title
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("go back"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
