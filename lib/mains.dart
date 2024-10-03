import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
        
          home:Screen()
    );
  }
}
class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen")), // Optional: Adding an AppBar for context
      body: Center(
        child:Column(children: [
          Container(
            height: 40,
             width:45,
             color:Colors.amber,
                     child: Text("Hello, World!"), // Example content
          )
        ],)

      ),
    );

  }
}