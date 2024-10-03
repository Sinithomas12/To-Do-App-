import 'package:flutter/material.dart';

class My extends StatelessWidget {
  const My({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        primary: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              color: Colors.black,
              child: Image.asset(
                'images/image1.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black26,
                shadowColor: Colors.red,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 70, // Set height for ListView
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text("A"),
                        subtitle: Text("letters"),
                        textColor: Colors.amberAccent,
                        leading: Icon(Icons.movie),
                        iconColor: Colors.blue,
                        trailing: Icon(Icons.more_horiz),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0), // Adds space between the cards
              child: Card(
                color: Colors.black26,
                shadowColor: Colors.red,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column( // Wrap ListTiles in a Column
                  children: [
                    ListTile(
                      title: Text("sachin"),
                      subtitle: Text("23"),
                      leading:  CircleAvatar(backgroundImage: AssetImage("images/image1.jpg"),),
                    ),
                    ListTile(
                      title: Text("pupp"),
                    ),
                    Image.asset("images/image1.jpg"),
                    Column(
                      mainAxisAlignment:  MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.abc_rounded))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
