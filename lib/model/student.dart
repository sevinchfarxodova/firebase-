class Student {
  String firstName;
  String lastName;
  int course;
  String faculty;
  String imageUrl;

  Student({
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.faculty,
    required this.imageUrl,
  });

  Student.fromJson(Map<String, dynamic> map)
      : firstName = map['firstName'],
        lastName = map['lastName'],
        course = map['course'],
        faculty = map['faculty'],
        imageUrl = map['imageUrl'];

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "course": course ,
      "faculty": faculty,
      "imageUrl": imageUrl,
    };
  }
}