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

  // List<String>? taskfromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return String(doc.data['task'] ?? '');
  //   });
  // }

  Stream<QuerySnapshot> get diffTasks {
    return taskData.snapshots();
  }
}
