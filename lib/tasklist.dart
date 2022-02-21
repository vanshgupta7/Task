// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // final tasssks = Provider.of<QuerySnapshot>(context);
    // for (var doc in tasssks.docs) {
    //   print(doc.data);
    // }
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No Tasks"),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  color: Colors.grey[200],
                  child: ListTile(
                    title: Text(doc.data().toString()),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
