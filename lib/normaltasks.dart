// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task/taskList.dart';
// import 'package:task/addtask.dart';
import 'completedtasks.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NormalTasks extends StatefulWidget {
  const NormalTasks({Key? key}) : super(key: key);

  @override
  _NormalTasksState createState() => _NormalTasksState();
}

class _NormalTasksState extends State<NormalTasks> {
  String taskEntered = "";
  bool _showSheet = false;
  final CollectionReference taskData =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> updateUserData(String tasks) async {
    print("Success");
    return await taskData.doc().set({
      'task': tasks,
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: TasksStorage().diffTasks,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Normal Tasks"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompletedTasks()),
                );
              },
              child: Text("Completed tasks"),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _showSheet = true;
            });
          },
        ),
        body: Center(
          child: Row(
            children: const [
              SizedBox(
                height: 500,
                width: 300,
                child: TaskList(),
              ),
            ],
          ),
        ),
        bottomSheet: _showSheet
            ? BottomSheet(
                elevation: 10,
                backgroundColor: Colors.grey,
                onClosing: () {
                  // Do something
                },
                builder: (BuildContext ctx) => Container(
                      width: double.infinity,
                      height: 250,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220.0,
                            height: 100,
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: 'Enter Task',
                                labelText: 'Task',
                              ),
                              onChanged: (value) => taskEntered = value,
                            ),
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                updateUserData(taskEntered);

                                _showSheet = false;
                              });
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _showSheet = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ))
            : null,
      ),
    );
  }
}
