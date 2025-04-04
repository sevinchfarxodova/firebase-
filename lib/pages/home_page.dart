import 'package:firebase_signs/core/routes/route_names.dart';
import 'package:firebase_signs/model/student.dart';
import 'package:firebase_signs/services/auth_services.dart';
import 'package:firebase_signs/services/real_time_db_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  bool isLoading = false;

  Future<void> createData() async {
    setState(() {
      isLoading = true;
    });
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    int course = int.parse(courseController.text.trim());
    String faculty = facultyController.text.trim();
    String imageUrl = imgUrlController.text.trim();

    Student student = Student(
      firstName: firstName,
      lastName: lastName,
      course: course,
      faculty: faculty,
      imageUrl: imageUrl,
    );
    if (await RealTimeDbService.createDatabase(student: student) == false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Something wrong')));
      print("xatolik");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Successfully created')));
      print("to'g'ri");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: Text(
          "Add Your Info",
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
              Navigator.pushNamed(context, RouteNames.fireStorePage);
            },
            icon: Icon(Icons.fireplace_sharp),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.all_students_info_page);
            },
            icon: Icon(Icons.arrow_circle_down_sharp),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              AuthService.logOut(context);
            },
            icon: Icon(Icons.logout),
            color: Colors.purpleAccent,
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
                      createData();
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
