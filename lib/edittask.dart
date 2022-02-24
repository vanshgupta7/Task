import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/normaltasks.dart';

class EditTask extends StatefulWidget {
  // const EditTask({Key? key}) : super(key: key);

  DocumentSnapshot doctoEdit;
  // ignore: use_key_in_widget_constructors
  EditTask({required this.doctoEdit});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String taskEntered = "";
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    taskEntered = widget.doctoEdit['task'];
    textEditingController =
        TextEditingController(text: widget.doctoEdit['task']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NormalTasks()),
              );
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 420.0,
            height: 200,
            decoration: BoxDecoration(border: Border.all()),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: 'Enter Task',
                labelText: 'Task',
              ),
              onChanged: (value) => taskEntered = value,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.doctoEdit.reference.update({
                'task': taskEntered,
              }).whenComplete(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NormalTasks()),
                  ));
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
