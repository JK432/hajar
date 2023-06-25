class Uuser {
  String uid;
  String roll;
  Uuser({
    this.uid = "",
    this.roll ="",
  });



  Map<String, dynamic> toJson() => {
    'uid': uid,
    'roll': roll,
  };
  static Uuser fromJson(Map<String, dynamic> Json) => Uuser(
    uid: Json['uid'],
    roll: Json['roll'],
  );
}
class Student {
  String id;
  String name;
  String email;
  String sem;
  String branch;
  String rollno;
  List<String> courseid;
  Student(
      {this.id = "",
        this.name = "",
        this.email = "",
        this.branch = "",
        this.sem = "",
        required this.courseid,
        this.rollno = ""});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'branch': branch,
    'sem': sem,
    'rollno': rollno,
    'courseid':courseid,
  };

  static Student fromJson(Map<String, dynamic> Json) => Student(
    name: Json['name'],
    id: Json['id'],
    email: Json['email'],
    branch: Json['branch'],
    courseid: dyntostr(Json['courseid']),
    rollno: Json['rollno'],
    sem: Json['sem'],
  );


  static List<String> dyntostr(List<dynamic> dynamiclist){
    List<String> stringlist = [];
    dynamiclist.forEach((element) {stringlist.add(element.toString());});
    return stringlist;
  }
}


class GenaralUser{
  String email= "";
  String uid= "";
  GenaralUser(String email,String uid){
    this.email=email;
    this.uid=uid;
  }
}

class Teacher {
  String id;
  String name;
  String email;

  Teacher(
      {this.id = "",
        this.name = "",
        this.email = "",
});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,

  };

  static Teacher fromJson(Map<String, dynamic> Json) => Teacher(
    name: Json['name'],
    id: Json['id'],
    email: Json['email'],

  );
}