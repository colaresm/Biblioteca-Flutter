class UserAuthenticate {
  dynamic username;
  dynamic password;

  UserAuthenticate({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> data = {
      username: this.username,
      password: this.password,
    };
    return data;
  }
}
