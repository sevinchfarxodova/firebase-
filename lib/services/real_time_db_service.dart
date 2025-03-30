import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../model/student.dart';

class RealTimeDbService {
  static Future<bool> createData({required Student student}) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child('students').push().set(student.toJson());
      print("Successfully created!");
      return true;
    } catch (e, s) {
      print("Error: $e");
      print("StackTrace: $s");
      return false;
    }
  }

  static Future<Map<String, Student>?> readData() async {
    Map<String, Student> mp = {};
    // get from firebase
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    Query _query = databaseReference.ref.child("students");
    DatabaseEvent event = await _query.once();
    DataSnapshot dataSnapshot = event.snapshot;

    // add to list
    for (var child in dataSnapshot.children) {
      print(child.key);
      var myJson = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(myJson);
      Student student = Student.fromJson(map);
      mp.addAll({child.key.toString(): student});
    }
    return mp;
  }

  // deleteData

  static Future<void> deleteData(String studentID) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("students").child(studentID).remove();
    print("Deleted");
  }

  // update
  static Future<void> updateData(Student newStudent, String studentId) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference
        .child('students')
        .child(studentId)
        .update(newStudent.toJson());
    print("Success");
  }
}
