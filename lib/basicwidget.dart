import 'package:flutter/material.dart';
import './Todoapp.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            backgroundColor: MaterialStateProperty.all(
              SelectedTaskType == "Today" ? Colors.black12  : Colors.transparent,
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
          ),
          onPressed: () {
            changeTaskType("Today");
          },
          child: const Text("Today"),
        ),

        // Tomorrow Button
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              SelectedTaskType == "Tomorrow" ? Colors.black12  : Colors.transparent,
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
          ),
          onPressed: () {
            changeTaskType("Tomorrow");
          },
          child: const Text("Tomorrow"),
        ),

        // Next Week Button
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              SelectedTaskType == "Next Week" ? Colors.black12 : Colors.transparent,
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
          ),
          onPressed: () {
            changeTaskType("Next Week");
          },
          child: const Text("Next Week"),
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
