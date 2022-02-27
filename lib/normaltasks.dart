// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task/taskList.dart';
import 'package:task/theme.dart';
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
  bool light = true;

  final CollectionReference taskData =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> updateUserData(String tasks, bool done) async {
    // print("Success");
    return await taskData.doc().set({
      'task': tasks,
      'completed': done,
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

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
              _showSheet = !_showSheet;
            });
          },
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: TaskList(),
              ),
              Switch(
                  value: light,
                  onChanged: (value) {
                    setState(() {
                      light = value;
                      light
                          ? _themeChanger.setTheme(MyThemes.darkTheme)
                          : _themeChanger.setTheme(MyThemes.lightTheme);
                    });
                  })
            ],
          ),
        ),
        bottomSheet: _showSheet
            // ignore: sized_box_for_whitespace
            ? Container(
                height: 400,
                child: BottomSheet(
                    elevation: 10,
                    // backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onClosing: () {
                      // Do something
                    },
                    builder: (BuildContext ctx) => Container(
                          width: double.infinity,
                          height: 250,
                          alignment: Alignment.center,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 420.0,
                                height: 200,
                                decoration: BoxDecoration(border: Border.all()),
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(15),
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
                                    updateUserData(taskEntered, false);

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
                        )),
              )
            : null,
      ),
    );
  }
}
