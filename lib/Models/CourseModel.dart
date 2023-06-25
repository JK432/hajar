class Course {
  String id;
  String teacherid;
  String name;
  String sem;
  String branch;
  List<String> students;
  Course(
      {this.id = "",
        this.name = "",
        this.teacherid="",
        this.branch = "",
        this.sem = "",
        required this.students,
        });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'branch': branch,
    'sem': sem,
    'teacherid': teacherid,
    'students':students
  };

  static Course fromJson(Map<String, dynamic> Json) => Course(
    name: Json['name'],
    id: Json['id'],
   students: dyntostr(Json['students']),
    branch: Json['branch'],
   teacherid:Json['teacherid'] ,
    sem: Json['sem'],
  );

  static List<String> dyntostr(List<dynamic> dynamiclist){
    List<String> stringlist = [];
    dynamiclist.forEach((element) {stringlist.add(element.toString());});
    return stringlist;
  }
}