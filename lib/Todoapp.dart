import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Map<String, bool> taskc = {};
  final CollectionReference app = FirebaseFirestore.instance.collection('app');
  TextEditingController task = TextEditingController();
  String SelectedTaskType = "Today";
  void changeTaskType(String type) {
    setState(() {
      SelectedTaskType = type;
    });
  }

  void deleteTask(tid) {
    app.doc(tid).delete();
  }

  Future<void> _addtask() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            controller: task,
            decoration: const InputDecoration(hintText: "Enter the task"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (task.text.isNotEmpty) {
                  app.add({
                    'name': task.text,
                    'type': SelectedTaskType
                  }); //Adding New Task

                  Navigator.of(context).pop();
                  task.clear();
                }
              },
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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

        /* leading: const Icon(Icons.person),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.access_alarm)),
        ],*/
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(240, 235, 241, 239),
              Color.fromARGB(255, 230, 236, 239),
              Colors.white60,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                    textStyle:
                        WidgetStatePropertyAll(const TextStyle(fontSize: 20)),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    changeTaskType("Today");
                  },
                  child: const Text(
                    "Today",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    textStyle:
                        WidgetStatePropertyAll(const TextStyle(fontSize: 20)),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    changeTaskType("Tomorrow");
                  },
                  child: const Text("Tomorrow"),
                ),
                TextButton(
                  style: ButtonStyle(
                    textStyle:
                        WidgetStatePropertyAll(const TextStyle(fontSize: 20)),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    changeTaskType("Next Week");
                  },
                  child: const Text(
                    "Next Week",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            // StreamBuilder to listen for changes in Firestore
            Expanded(
              child: StreamBuilder(
                stream:
                    app.where('type', isEqualTo: SelectedTaskType).snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot appsnap =
                            snapshot.data.docs[index];
                        final taskid = appsnap.id;

                        return Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                activeColor: Colors.transparent,
                                value: taskc[taskid] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    taskc[taskid] = val!;
                                  });
                                },
                                title: Text(
                                  appsnap['name'],
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteTask(appsnap
                                    .id); // Add functionality to delete the task if needed
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading tasks'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addtask();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
