
import 'package:flutter/material.dart';
void main() {
  runApp(const MyWidget()); // Change here to use MyApp
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var dsp="hello";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
Text(
  dsp,
  style: TextStyle(fontSize: 20),
),
ElevatedButton(onPressed: (){dsp="hai" ;}, child: Text("click"), )
      ],),
    );
  }
}