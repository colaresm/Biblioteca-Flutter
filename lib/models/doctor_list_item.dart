class Doctor {
  final String id;
  final String name;
  final String serviceCity;
  final String firstPhone;
  final String speciality;
  final String serviceState;
  final String serviceNeighborhood;
  final String serviceStreet;
  final String serviceNumber;
  final Object profilePicture;

  const Doctor(
      {required this.id,
      required this.name,
      required this.serviceCity,
      required this.serviceNeighborhood,
      required this.serviceNumber,
      required this.serviceStreet,
      required this.serviceState,
      required this.firstPhone,
      required this.speciality,
      required this.profilePicture});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    toCheckProfilePicture(profilePicture) {
      if (profilePicture == null) {
        return "";
      } else {
        return profilePicture['content'];
      }
    }

    return Doctor(
        id: json['id'],
        name: json['name'],
        serviceCity: json['serviceCity'],
        serviceNeighborhood: json['serviceNeighborhood'],
        firstPhone: json['firstPhone'],
        speciality: json['speciality'],
        serviceNumber: json['serviceNumber'],
        serviceState: json['serviceState'],
        serviceStreet: json['serviceStreet'],
        profilePicture: toCheckProfilePicture(json['profilePicture']));
  }
}
