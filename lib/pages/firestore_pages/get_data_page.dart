import 'package:firebase_signs/model/student.dart';
import 'package:firebase_signs/services/firestore_service.dart';
import 'package:firebase_signs/services/real_time_db_service.dart';
import 'package:flutter/material.dart';

class AllFireStoreStudentsInfoPage extends StatefulWidget {
  const AllFireStoreStudentsInfoPage({super.key});

  @override
  State<AllFireStoreStudentsInfoPage> createState() =>
      _AllFireStoreStudentsInfoPageState();
}

class _AllFireStoreStudentsInfoPageState
    extends State<AllFireStoreStudentsInfoPage> {
  List<String> ids = [];
  List<Student> students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, Student>? data = await FireStoreService.readData();
    if (data == null) {
      print("Firestore data is null");
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      ids = data.keys.toList();
      students = data.values.toList();
      isLoading = false;
    });
  }

  Future<void> deleteData({required String id}) async {
    await FireStoreService.deleteData(id);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: Text(
          "FireStore Students Info",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
        isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: ids.length,
          itemBuilder: (context, index) {
            Student student = students[index];
            return ListTile(
              leading: IconButton(
                onPressed: () {
                  bottomSheet(
                      context: context, id: ids[index], student: student);
                },
                icon: Icon(
                  Icons.edit_note_rounded,
                  color: Colors.black,
                ),
              ),
              title: Column(
                children: [
                  Text(
                    student.firstName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    student.lastName,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  // deleteStudent(id: ids[index]);
                  deleteData(id: ids[index]);
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void bottomSheet({
    required BuildContext context,
    required String id,
    required Student student,
  }) {
    TextEditingController firstNameController = TextEditingController(
      text: student.firstName,
    );
    TextEditingController lastNameController = TextEditingController(
      text: student.lastName,
    );
    TextEditingController courseController = TextEditingController(
      text: student.course.toString(),
    );
    TextEditingController facultyController = TextEditingController(
      text: student.faculty,
    );

    TextEditingController imgUrlController = TextEditingController(
      text: student.imageUrl,
    );
    showModalBottomSheet(
      backgroundColor: Colors.purpleAccent.shade100,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: "Name...",
                  hintStyle: TextStyle(color: Colors.purple.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: "LatName...",
                  hintStyle: TextStyle(color: Colors.purple.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: courseController,
                decoration: InputDecoration(
                  hintText: "Course...",
                  hintStyle: TextStyle(color: Colors.purple.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: facultyController,
                decoration: InputDecoration(
                  hintText: "Faculty...",
                  hintStyle: TextStyle(color: Colors.purple.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: imgUrlController,
                decoration: InputDecoration(
                  hintText: "IMG...",
                  hintStyle: TextStyle(color: Colors.purple.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String firstName = firstNameController.text.trim();
                  String lastName = lastNameController.text.trim();
                  int course = int.parse(courseController.text.trim());
                  String faculty = facultyController.text.trim();
                  String imgUrl = imgUrlController.text.trim();

                  Student student = Student(
                    firstName: firstName,
                    lastName: lastName,
                    course: course,
                    faculty: faculty,
                    imageUrl: imgUrl,
                  );

                  await FireStoreService.updateData(id, student);
                  getData();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
