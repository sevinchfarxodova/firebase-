import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:firebase_database/firebase_database.dart';

import '../model/student.dart';


class RealTimeDbService {
  static Future<bool> createDatabase({required Student student}) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child('students').push().set(student.toJson());
      print('Stored Successful');
      return true;
    } catch (e,d) {
      print(e);
      print("xatolik $d");
      return false;
    }
  }
  static Future<Map<String,Student>?> readData() async{
    Map<String,Student> mp = {};
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    Query _query = databaseReference.ref.child('students');
    DatabaseEvent databaseEvent = await _query.once();
    DataSnapshot dataSnapshot = databaseEvent.snapshot;

    for(var child in dataSnapshot.children){
      print(child.key);
      var myJson = jsonEncode(child.value);
      Map<String,dynamic> map = jsonDecode(myJson);
      Student student = Student.fromJson(map);
      mp.addAll({child.key.toString():student});
    }
    return mp;
  }

  static Future<void> updateData(Student newStudent,String studentKey) async{
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child('students').child(studentKey).update(newStudent.toJson());
    print('Student update successful');
  }

  static Future<void> deleteData(String studentId) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child('students').child(studentId).remove();
    print('Student delete successful');
  }
}