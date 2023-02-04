class DoctorParams {
  String? speciality;
  String? state;
  String? city;

  DoctorParams({this.speciality, this.state, this.city});

  DoctorParams.fromJson(Map<String, dynamic> json) {
    speciality = json['speciality'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speciality'] = this.speciality;
    data['state'] = this.state;
    data['city'] = this.speciality;

    return data;
  }
}
