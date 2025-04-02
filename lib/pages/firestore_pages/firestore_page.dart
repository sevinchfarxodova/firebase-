import 'package:firebase_signs/core/routes/route_names.dart';
import 'package:firebase_signs/services/firestore_service.dart';
import 'package:flutter/material.dart';
import '../../model/student.dart';

class FirestorePage extends StatefulWidget {
  const FirestorePage({super.key});

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  bool isLoading = false;

  void createStudent() async {
    setState(() {
      isLoading = true;
    });
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
    if (await FireStoreService.createData(student)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success", style: TextStyle(color: Colors.green)),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something wrong", style: TextStyle(color: Colors.red)),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  void clear(){
    firstNameController.clear();
    lastNameController.clear();
    courseController.clear();
    facultyController.clear();
    imgUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,

      appBar: AppBar(
        title: Text(
          "FireStore ",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple.shade700,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.fireStoreStudentsPage);
            },
            icon: Icon(Icons.dataset),
            color: Colors.white,
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // infos
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: "First name...",
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
                hintText: "Last name...",
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
                hintText: "Image...",
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
            // button create
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      createStudent();
                      clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
