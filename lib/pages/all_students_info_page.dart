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
    if (students == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      ids = students.keys.toList();
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
                    return Card(
                      color: Colors.purple.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            bottomSheet(
                              context: context,
                              id: ids[index],
                              student: student,
                            );
                          },
                          icon: Icon(
                            Icons.edit_note_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(
                              student.firstName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              student.lastName,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            deleteStudent(id: ids[index]);
                          },
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                            size: 28,
                          ),
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
        return Container(
          color: Colors.purple.shade100,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(firstNameController, "Name..."),
              SizedBox(height: 20),
              _buildTextField(lastNameController, "LastName..."),
              SizedBox(height: 20),
              _buildTextField(courseController, "Course..."),
              SizedBox(height: 20),
              _buildTextField(facultyController, "Faculty..."),
              SizedBox(height: 20),
              _buildTextField(imgUrlController, "IMG..."),
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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.purple.shade300,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.purple.shade400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
