import 'package:cloud_firestore/cloud_firestore.dart';

class TasksStorage {
  // String uid;
  // TasksStorage({required this.uid});
  final CollectionReference taskData =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> updateUserData(String tasks) async {
    return await taskData.doc().set({
      'task': tasks,
    });
  }

  Stream<QuerySnapshot> get diffTasks {
    return taskData.snapshots();
  }
}
