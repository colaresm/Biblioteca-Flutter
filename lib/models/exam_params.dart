class ExamParams {
  String? name;
  String? date;

  ExamParams({this.name, this.date});

  ExamParams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;

    return data;
  }
}
