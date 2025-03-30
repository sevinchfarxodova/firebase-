import 'package:firebase_signs/model/student.dart';
import 'package:firebase_signs/services/real_time_db_service.dart';
import 'package:flutter/material.dart';

class AllStudentsInfoPage extends StatefulWidget {
  const AllStudentsInfoPage({super.key});

  @override
  State<AllStudentsInfoPage> createState() => _AllStudentsInfoPageState();
}

class _AllStudentsInfoPageState extends State<AllStudentsInfoPage> {
  List<String> ids = [];
  List<Student> studentsList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, Student>? students = await RealTimeDbService.readData();
    setState(() {
      ids = students!.keys.toList();
      studentsList = students.values.toList();
      isLoading = false;
    });
  }

  Future<void> deleteStudent({required String id}) async {
    await RealTimeDbService.deleteData(id);
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: Text(
          "Students Info",
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
                    Student student = studentsList[index];
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {},
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
                          Text(student.course.toString()),
                          Text(student.faculty),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          deleteStudent(id: ids[index]);
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
              TextField(
                controller: lastNameController,
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
                controller: courseController,
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

                  await RealTimeDbService.updateData(student, id);
                  readData();
                },
                child: Text("Update"),
              ),
            ],
          ),
        );
      },
    );
  }
}
