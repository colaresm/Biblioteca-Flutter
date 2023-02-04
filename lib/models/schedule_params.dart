class ScheduleParams {
  String? id;
  String? status;
  String? date;
  String? time;
  String? doctorName;

  ScheduleParams({this.id, this.status, this.date, this.time, this.doctorName});

  ScheduleParams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    doctorName = json['doctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    data['doctorName'] = this.doctorName;
    return data;
  }
}
