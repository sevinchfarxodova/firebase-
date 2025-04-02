import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signs/model/student.dart';

class FireStoreService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> createData(Student student) async {
    try {
      final CollectionReference students = firestore.collection("students");
      await students.add(student.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<Map<String, Student>> readData() async {
    Map<String, Student> data = {};
    try {
      final CollectionReference students = firestore.collection("students");
      QuerySnapshot snapshot = await students.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        Student student = Student.fromJson(map);
        data[doc.id] = student;
      }
      return data;
    } catch (e) {
      print("Error reading data: $e");
      return {};
    }
  }

  static updateData(String id, Student student) async {
    final CollectionReference students = firestore.collection("students");
    await students.doc(id).update(student.toJson());
  }

  static deleteData(String id) async {
    final CollectionReference students = firestore.collection("students");
    await students.doc(id).delete();
  }
}
