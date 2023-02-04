class RecoverPassword {
  dynamic email;
  dynamic code;
  dynamic newPassword;

  RecoverPassword({this.email, this.code, this.newPassword});

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['email'] = this.email ?? '';
    data['code'] = this.code ?? '';
    data['newPassword'] = this.newPassword ?? '';
    return data;
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> data = {
      email: this.email ?? '',
      code: this.code ?? '',
      newPassword: this.newPassword ?? '',
    };
    return data;
  }
}
