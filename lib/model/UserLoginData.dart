class UserLoginData {
  String? email;
  String? password;

  UserLoginData({this.email, this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password
  };
}
