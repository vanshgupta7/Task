// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/edittask.dart';
import 'package:task/theme.dart';
import 'package:provider/provider.dart';

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
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                // children: snapshot.data!.docs.map((doc) {
                itemBuilder: (context, index) {
                  return snapshot.data!.docs[index]['completed'] == false
                      ? Card(
                          // color: Colors.grey[200],
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTask(
                                          doctoEdit: snapshot.data!.docs[index],
                                        )),
                              );
                            },
                            title: Text(snapshot.data!.docs[index]['task']),
                            leading: Checkbox(
                                value: snapshot.data!.docs[index]['completed'],
                                activeColor: Colors.green,
                                onChanged: (bool? newValue) {
                                  snapshot.data!.docs[index].reference.update({
                                    'completed': newValue,
                                  });
                                }),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("tasks")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            ),
                          ),
                        )
                      : Container();
                });
          }
        },
      ),
    );
  }
}
