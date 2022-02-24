// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Normal tasks"),
          )
        ],
      ),
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
                  return snapshot.data!.docs[index]['completed'] == true
                      ? Card(
                          color: Colors.grey[200],
                          child: ListTile(
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditTask(
                            //               doctoEdit: snapshot.data!.docs[index],
                            //             )),
                            //   );
                            // },
                            title: Text(snapshot.data!.docs[index]['task']),
                            // leading: Checkbox(
                            //     value: snapshot.data!.docs[index]['completed'],
                            //     activeColor: Colors.green,
                            //     onChanged: (bool? newValue) {
                            //       snapshot.data!.docs[index].reference.update({
                            //         'completed': newValue,
                            //       });
                            //     }),
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
