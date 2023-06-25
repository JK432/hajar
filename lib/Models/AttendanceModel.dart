class Attendance {
  String id;
  String time;
  String date;
  List<String>present;
  List<String>absent;
  Attendance(
      {this.id = "",
       this.time="",
        this.date="",
       required this.present,
        required this.absent,
      });

  Map<String, dynamic> toJson() => {
    'id': id,
    'time': time,
    'date': date,
    'present': present,
    'absent': absent,
  };

  static Attendance fromJson(Map<String, dynamic> Json) => Attendance(
    id: Json['id'],
    absent: dyntostr(Json['absent']),
    present: dyntostr(Json['present']),
    date:Json['date'],
    time:Json['time'],
  );

  static List<String> dyntostr(List<dynamic> dynamiclist){
    List<String> stringlist = [];
    dynamiclist.forEach((element) {stringlist.add(element.toString());});
    return stringlist;
  }
}